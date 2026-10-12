# 更新词库

**每次新增单词，只提交一个新的 JSON 文件到 `assets/dictionary/additions/`。**
例如 `assets/dictionary/additions/2026-10-12-food.json`。
无需修改 `greek.json`、Dart 代码、`pubspec.yaml` 或文件清单。
一个文件可以包含一个或多个单词，也可以包含短语和语法练习。

应用自动发现目录里的所有 `.json` 文件，按文件名排序，然后把词条加入
文件中指定的学习分组。`greek.json` 保留为基础词库；增量文件在加载时
合并到内存中的完整词库，不会改写基础文件。不需要生成 Dart 代码或运行 NLP。

提交到 `main` 后，现有 GitHub Actions 会运行检查、构建并发布网页；
浏览器刷新应用后使用新词库。原生 Android 应用需要重新打包安装才能
取得更新后的内置词库。目前没有独立的在线词库下载机制。

## 基础词库结构

- `schemaVersion`：目前为 `1`。
- `cards`：词条和练习定义。每个键是可被分组引用的唯一字符串。
- `collections`：应用主页的学习分组，包括 `words`、`phrases`、`grammar`。
  每组的 `deck.cards` 是词条键的数组，`themes` 按词条的 `id` 标注主题。
- `decks`：原有来源主题，用于兼容原有分类和回归验证；主页使用
  `collections`。新增主页词条不需要修改 `decks`。

`cards` 中有些定义是同一个词的不同练习，例如单词本身和带冠词的语法练习。
修改前应找到目标学习分组的 `deck.cards` 引用，再编辑对应定义。
多个分组可以引用同一个定义，避免重复维护。

## 新增单词文件

1. 复制 [`new-words.example.json`](new-words.example.json) 到
   `assets/dictionary/additions/`，使用新的文件名。文件放在此目录的第一层，
   不要放进子文件夹。
2. 修改词条内容。完整文件格式如下：

```json
{
  "schemaVersion": 1,
  "addedWeek": "2026-10-12",
  "words": [
    {
      "id": "pear-2026-10",
      "collection": "words-nouns",
      "greek": "αχλάδι",
      "answerDisplay": "το αχλάδι",
      "prompt": {"en": "Pear", "ru": "Груша"},
      "pronunciation": {"en": "a-HLA-dhi", "ru": "а-ХЛА-ди"},
      "labels": ["noun"],
      "themes": ["food"]
    }
  ]
}
```

3. **只提交这个新文件**。网页发布流程自动检查并发布合并后的词库。

`collection` 指定已有分组，例如 `words-nouns`、`words-verbs`、
`words-pronouns`、`words-descriptions`、`words-connectors`、`words-numbers`、
`phrases-social`、`phrases-classroom`、`phrases-everyday`。语法分组可使用
基础词库中的 `grammar-*` 分组 ID。未知分组会报错。

文件可以任意命名。词条的 `id` 必须唯一，不要在不同文件中重复提交同一个
ID。新增文件只追加词条，重复 ID、重复复习记录键或错误字段会阻止发布，
不会静默覆盖旧词条。修改已经存在的词条时，编辑它所在的文件。

相同希腊语单词使用不同 ID 提交新含义时，会自动合并为一个单词定义：
`senses` 保留各个含义，显示提示合并含义，词性标签、主题和说明取并集。
同词属于多个词性时，多个分组引用同一个定义。匹配保留重音，`που` 与
`πού` 不会合并。短语和语法练习保留各自的训练用途。

合并后的词条保留最早添加日期；`aliases` 记录旧词条 ID，`reviewAliases`
保留旧复习记录键。已有主记录优先使用，主记录不存在时读取旧别名记录，
之后的复习写入主记录。新含义请使用新的唯一 ID，避免覆盖已有内容。

## 字段规则

同义的阴阳形式使用相同的 `wordGroup`（例如 `teacher`），加载时自动合成
一张卡。`prompt` 应使用不限定性别的含义。当前词库已合并 22 组；每张卡
的 `forms` 保存各形式的 `greek`、`answerDisplay` 和 `pronunciation`，
两种形式都能答对，旧卡 ID 和复习记录通过别名保留。
以后提交已有形式的新含义会自动归入该卡；新增另一种性别拼写时，
在新词条上填写相同的 `wordGroup` 即可。不要将含义不同的词设置为同一组。
此规则只作用于单词，语法练习仍按题目要求判定阴阳形式。

新增文件中的必填词条字段为 `id`、`collection`、`prompt`、`greek`、
`pronunciation`；日期可通过文件顶层的 `addedWeek` 统一指定，或在词条中
单独指定。`meaning` 默认是“翻译成希腊语”。`reviewIdentity` 默认由
`collection` 和 `id` 生成，重命名文件不会影响复习记录。所有本地化文本
包含 `en` 和 `ru`；希腊语使用正常 Unicode 文本，并保留重音。

可选字段包括 `explanation`、`answerDisplay`、`alternatives`、
`acceptedAnswers`、`labels`、`addedWeek` 和 `words`。`alternatives` 是显示的
替代拼写，`acceptedAnswers` 是额外接受的完整答案。新词条可省略 `words`，
应用主页的词条、主题和分组不依赖自动分词。

`words-nouns` 中的新增名词会自动接受带冠词和不带冠词的答案。
例如模板中的 `greek: "αχλάδι"` 和 `answerDisplay: "το αχλάδι"`
都能答对，无需在 `acceptedAnswers` 中重复填写。阴阳形式分别使用
`forms` 中的 `greek` 和 `answerDisplay`，不要把带斜线的组合显示当作答案。
只有词汇名词应用此规则；短语和语法练习仍要求指定的冠词，重音始终必填。

`addedWeek` 必须是该周星期一的 `YYYY-MM-DD` 日期，用于周筛选。
`labels` 支持 `noun`、`verb`、`adjective`、`adverb`、`pronoun`、`article`、
`preposition`、`conjunction`、`numeral`、`interjection`。
主题支持 `people`、`family`、`classroom`、`home`、`food`、`places`、
`travel`、`phone`、`time`、`conversation`。

**已有词条的 `reviewIdentity.deckId` 和 `reviewIdentity.cardId` 应保持不变。**
复习记录使用这两个字段作为键。若已有增量词条需要更换 `collection`，
显式保留原来的 `reviewIdentity`，以继续使用原复习记录。
一个分组内的词条 `id` 不可重复。

## 检查与旧文件

可在本地运行 `flutter analyze` 和 `flutter test`。测试会读取词典文件，
自动发现并合并所有增量文件，检查重复 ID、字段、日期和主题；
格式错误会阻止网页发布。应用读取失败时显示
现有的加载错误与重试界面。

旧 Dart 词库已移到 `tool/legacy_data/`，只用于历史回归测试和迁移工具，
应用不会读取它。不要通过修改这些旧文件来更新词库。
`tool/migrate_dictionary.dart` 是一次性导出工具；已有词典时会拒绝覆盖。
