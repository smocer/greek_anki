import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const everydayPlacesDeck = VocabularyDeck(
  id: 'everyday-places',
  title: LocalizedText(en: 'Everyday places', ru: 'Места на каждый день'),
  subtitle: LocalizedText(
    en: 'A place name and its location form',
    ru: 'Название места и форма «в…»',
  ),
  note: LocalizedText(
    en: 'Pairs show the nominative article and σε + accusative: the bank / at the bank. Russian grammatical gender is not a reliable guide.',
    ru: 'Пары показывают именительный и σε с винительным: банк / в банке. Род русского перевода не определяет греческий артикль.',
  ),
  cover: 'Στο',
  cards: [
    VocabularyCard(
      id: 'airport',
      prompt: LocalizedText(
        en: 'The airport (with article)',
        ru: 'Аэропорт (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το αεροδρόμιο',
      pronunciation: LocalizedText(
        en: 'to a-e-ro-DHRO-mi-o',
        ru: 'то а-э-ро-ДРО-ми-о',
      ),
      explanation: LocalizedText(
        en: 'Neuter. The αερο- root is familiar from aeroplane.',
        ru: 'Средний род. Корень αερο- знаком по «аэропорт», «аэродром»; греческое αεροδρόμιο — именно аэропорт.',
      ),
    ),
    VocabularyCard(
      id: 'at-airport',
      prompt: LocalizedText(en: 'At the airport', ru: 'В аэропорту'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'στο αεροδρόμιο',
      pronunciation: LocalizedText(
        en: 'sto a-e-ro-DHRO-mi-o',
        ru: 'сто а-э-ро-ДРО-ми-о',
      ),
      explanation: LocalizedText(
        en: 'Σε + το gives στο; αεροδρόμιο keeps its ending.',
        ru: 'Русское «в аэропорту» — предложный; греческое στο αεροδρόμιο — винительный после σε.',
      ),
    ),
    VocabularyCard(
      id: 'bank',
      prompt: LocalizedText(
        en: 'The bank (with article)',
        ru: 'Банк (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'η τράπεζα',
      pronunciation: LocalizedText(en: 'i TRA-pe-za', ru: 'и ТРА-пэ-за'),
      explanation: LocalizedText(
        en: 'Τράπεζα means bank in this everyday context.',
        ru: 'Род женский, хотя «банк» мужского. Корень знаком по «трапеза», но здесь значение — финансовый банк.',
      ),
    ),
    VocabularyCard(
      id: 'at-bank',
      prompt: LocalizedText(en: 'At the bank', ru: 'В банке'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'στην τράπεζα',
      pronunciation: LocalizedText(en: 'stin TRA-pe-za', ru: 'стин ТРА-пэ-за'),
      explanation: LocalizedText(
        en: 'Σε + την = στην; keep ν before τ.',
        ru: 'Η τράπεζα → στην τράπεζα. После σε нужен винительный; род греческого слова — женский.',
      ),
    ),
    VocabularyCard(
      id: 'university',
      prompt: LocalizedText(
        en: 'The university (with article)',
        ru: 'Университет (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το πανεπιστήμιο',
      pronunciation: LocalizedText(
        en: 'to pa-ne-pi-STI-mi-o',
        ru: 'то па-нэ-пи-СТИ-ми-о',
      ),
      explanation: LocalizedText(
        en: 'A neuter noun; higher studies use σπουδάζω.',
        ru: 'Το πανεπιστήμιο среднего рода. «Учусь в вузе» — σπουδάζω, не просто διαβάζω «читаю».',
      ),
    ),
    VocabularyCard(
      id: 'at-university',
      prompt: LocalizedText(en: 'At the university', ru: 'В университете'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'στο πανεπιστήμιο',
      pronunciation: LocalizedText(
        en: 'sto pa-ne-pi-STI-mi-o',
        ru: 'сто па-нэ-пи-СТИ-ми-о',
      ),
      explanation: LocalizedText(
        en: 'The place follows στο, not στην.',
        ru: 'Το → στο: средний род. Не выбираем артикль по русскому мужскому роду «университет».',
      ),
    ),
    VocabularyCard(
      id: 'supermarket',
      prompt: LocalizedText(
        en: 'The supermarket (with article)',
        ru: 'Супермаркет (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το σουπερμάρκετ',
      pronunciation: LocalizedText(
        en: 'to su-per-MAR-ket',
        ru: 'то су-пэр-МАР-кэт',
      ),
      explanation: LocalizedText(
        en: 'A neuter loanword; σούπερ μάρκετ is another spelling.',
        ru: 'Заимствование среднего рода, окончание не склоняется. Можно писать слитно или σούπερ μάρκετ.',
      ),
      alternatives: ['το σούπερ μάρκετ'],
    ),
    VocabularyCard(
      id: 'at-supermarket',
      prompt: LocalizedText(en: 'At the supermarket', ru: 'В супермаркете'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'στο σουπερμάρκετ',
      pronunciation: LocalizedText(
        en: 'sto su-per-MAR-ket',
        ru: 'сто су-пэр-МАР-кэт',
      ),
      explanation: LocalizedText(
        en: 'Σε + το = στο; the borrowed noun is unchanged.',
        ru: 'В русском «супермаркет → супермаркете», а в греческом слово неизменно, меняется артикль.',
      ),
      alternatives: ['στο σούπερ μάρκετ'],
    ),
  ],
);
