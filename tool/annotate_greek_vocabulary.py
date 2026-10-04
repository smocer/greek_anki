"""Local Greek token annotation, with contextual corrections and reviewed overrides.

Called by sync_vocabulary_metadata.py. The Flutter app uses generated data and
needs no Python, model download, or network at runtime.
"""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PIPELINE_VERSION = '2'
POS = {'NOUN':'noun', 'PROPN':'noun', 'VERB':'verb', 'AUX':'verb', 'ADJ':'adjective',
       'ADV':'adverb', 'PRON':'pronoun', 'ADP':'preposition', 'CCONJ':'conjunction',
       'SCONJ':'conjunction', 'NUM':'numeral', 'INTJ':'interjection'}
ARTICLES = {'ο','η','το','οι','τα','τον','την','τη','του','της','τους','τις','των'}
FUSED = {'στο','στη','στην','στον','στα','στους','στις'}
ONE = {'ένα','ένας','έναν','μια','μία','μιας','μίας'}

def read(path, default):
    return json.loads(path.read_text(encoding='utf-8')) if path.exists() else default

def write(path, value):
    path.write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')

def key_for(card):
    return f'{card["source"]}.{card["sourceId"]}'

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input',type=Path,required=True)
    parser.add_argument('--hints',type=Path,required=True)
    args=parser.parse_args()
    cards=json.loads(args.input.read_text(encoding='utf-8'))
    metadata=read(ROOT/'tool/vocabulary_metadata.json',{})
    overrides=read(ROOT/'tool/vocabulary_token_overrides.json',{'words':{},'cards':{}})
    hints=read(args.hints,{})
    # Reviewed short entries help the news-trained model with beginner forms.
    reviewed={}
    for card in cards:
        text=card['greek'].strip(' .!;…').lower()
        labels=metadata[key_for(card)]['labels']
        parts=text.split()
        if len(parts)==2 and parts[0] in ARTICLES and 'noun' in labels:
            reviewed.setdefault(parts[1],set()).add('noun')
        if len(parts)==1 and len(labels)==1 and labels[0] in {'noun','verb','adverb','interjection','numeral','pronoun'} and text not in ONE:
            reviewed.setdefault(text,set()).add(labels[0])
    for word,classes in reviewed.items():
        if len(classes)==1: hints.setdefault(word,{'labels':list(classes)})
    hints.update(overrides['words'])
    reviewed_labels={key_for(card):metadata[key_for(card)]['labels'] for card in cards}
    signature=hashlib.sha256(json.dumps([PIPELINE_VERSION,hints,overrides,reviewed_labels],sort_keys=True,ensure_ascii=False).encode()).hexdigest()
    path=ROOT/'tool/vocabulary_tokens.json'
    saved=read(path,{'signature':'','cards':{}})
    previous=saved['cards'] if saved.get('signature')==signature else {}
    nlp=None; annotations={}
    for card in cards:
        key=key_for(card)
        if key in annotations: continue
        text=card['greek']
        if key in previous and previous[key]['greek']==text:
            annotations[key]=previous[key]; continue
        if nlp is None:
            try:
                import spacy
                nlp=spacy.load('el_core_news_sm',disable=['ner'])
            except (ImportError,OSError) as error:
                raise RuntimeError('Install tool/vocabulary_nlp_requirements.txt in .dart_tool/vocabulary_nlp first') from error
        doc=nlp(text.lower())
        lexical=[t for t in doc if not t.is_space and not t.is_punct]
        tokens=[]
        for token in lexical:
            label=POS.get(token.pos_)
            labels=[label] if label else []
            if token.pos_=='DET': labels=['article'] if token.text in ARTICLES|ONE or 'Art' in token.morph.get('PronType') else ['pronoun']
            result={'surface':text[token.idx:token.idx+len(token.text)], 'lemma':token.lemma_.lower(),
                    'labels':labels,'tag':token.pos_,'start':token.idx,'end':token.idx+len(token.text)}
            result.update(hints.get(token.text,{}))
            if token.text in FUSED: result.update(labels=['preposition','article'],lemma='σε + ο')
            tokens.append(result)
        # A reviewed standalone entry has no sentence ambiguity.
        labels=metadata[key]['labels']
        if len(tokens)==1 and len(labels)==1: tokens[0]['labels']=labels
        if len(tokens)==2 and tokens[0]['surface'].lower() in ARTICLES and 'noun' in labels:
            tokens[0]['labels']=['article']; tokens[1]['labels']=['noun']
        if 'numeral' in labels:
            for token in tokens: token['labels']=['numeral']
        for index,token in enumerate(tokens):
            word=token['surface'].lower()
            following=tokens[index+1]['labels'] if index+1<len(tokens) else []
            if word in {'με','σε'}:
                token['labels']=['pronoun'] if 'verb' in following else ['preposition']
            if word in ARTICLES and not (len(tokens)==1 and labels==['article']):
                nominal=bool(set(following)&{'noun','adjective','numeral'})
                token['labels']=['article'] if nominal or word in {'ο','η','οι','των'} else ['pronoun']
            if word in ONE and len(tokens)>1 and ('noun' in following or 'adjective' in following):
                token['labels']=['article']
            for override_key,value in overrides['cards'].get(key,{}).items():
                if int(override_key)==index: token.update(value)
        annotations[key]={'greek':text,'tokens':tokens}
    dates_path=ROOT/'tool/vocabulary_word_dates.json'
    dates=read(dates_path,{})
    # Preserve a word's first recorded week when it reappears in new sentences.
    candidates={}
    for key,entry in annotations.items():
        for token in entry['tokens']:
            for label in token['labels']:
                word_key=label+':'+token['surface'].lower()
                week=metadata[key]['addedWeek']
                candidates[word_key]=min(week,candidates.get(word_key,week))
    for word_key,week in candidates.items(): dates.setdefault(word_key,week)
    write(dates_path,dates)
    write(path,{'signature':signature,'model':'el_core_news_sm-3.8.0','cards':annotations})
    dart=["// Generated by tool/sync_vocabulary_metadata.py; edit token overrides for corrections.",
          "import '../domain/vocabulary.dart';", "import '../domain/vocabulary_category.dart';", "",
          "const vocabularyWords = <String,List<VocabularyToken>>{"]
    for key,entry in sorted(annotations.items()):
        dart.append(f"  {json.dumps(key,ensure_ascii=False)}: [")
        for token in entry['tokens']:
            labels=', '.join('VocabularyLabel.'+label for label in token['labels'])
            weeks=[dates[label+':'+token['surface'].lower()] for label in token['labels']]
            week=min(weeks) if weeks else metadata[key]['addedWeek']
            field=lambda name: json.dumps(token[name],ensure_ascii=False).replace('$',r'\$')
            dart.append(f"    VocabularyToken(surface:{field('surface')}, lemma:{field('lemma')}, labels:[{labels}], start:{token['start']}, end:{token['end']}, tag:{field('tag')}, addedWeek:'{week}'),")
        dart.append('  ],')
    dart.append('};')
    (ROOT/'lib/data/vocabulary_words.dart').write_text('\n'.join(dart)+'\n',encoding='utf-8')
    print(f'Annotated {len(annotations)} cards; {len(candidates)} word/class pairs')

if __name__=='__main__': main()
