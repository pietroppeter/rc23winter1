import nimib, print

nbInit
nbText: """
# Language Identification

An exercise from our first session of NLP Study Group.

## Dataset

- Subset of Europarl corpus
- 2k sentences for 5 languages: English, Spanish, French, Italian, German.
"""
nbCode:
  import std / [sequtils, strutils]

  type
    Lang = enum de, en, es, fr, it 

  proc readSentences(lang: Lang): seq[string] =
    withDir nb.thisDir:
      toSeq lines "langid-corpus/sentences." & $lang & ".txt"

  var corpus: array[Lang, seq[string]]
  for lang in Lang:
    corpus[lang] = readSentences lang
    echo "Lang: ", lang
    echo "#sentences: ", len corpus[lang]
    echo "first 5 sentences:"
    echo corpus[lang][0 .. 5].join("\n")
    echo "..."
    echo "last 5 sentences:"
    echo corpus[lang][^5 .. ^1].join("\n")
    echo "---"
nbText: """
## Modelling strategy

- philosphy: use the minimal tool for the task
- start with the simplest possible model
- iterate adding slowly complexity and evaluating step by step

modelling hierarchy:
- random model (baseline)
- single char frequency model (for e, then for every char)
- 2-chars frequencies model

"""
nbCode:
  import std / tables

  const maxLenGram = 3

  type
    LangNgramModel = object
      ngrams: array[1 .. maxLenGram, CountTable[string]]
      byLang: array[Lang, CountTable[string]]
    LangDataset = seq[tuple[sentence: string ,lang: Lang]]

  proc fit(model: var LangNgramModel, dataset: LangDataset) =
    for lenGram in 1 .. maxLenGram:
      for row in dataset:
        for i in 0 .. (row.sentence.len - lenGram):
          let ngram = row.sentence[i ..< i + lenGram]
          model.ngrams[lenGram].inc ngram
          model.byLang[row.lang].inc ngram

  var model = LangNgramModel()
  let helloDataset = @[
    ("hallo", de),
    ("hello", en),
    ("hola", es),
    ("salut", fr),
    ("ciao", it),
  ]
  model.fit helloDataset

  func `$`(model: LangNgramModel): string =
    for lenGram in 1 .. maxLenGram:
      result.add $lenGram & "-grams:\n"
      var tot: int
      var totByLang: array[Lang, int]
      for ngram, count in model.ngrams[lenGram]:
        result.add "  " & ngram & ": " & $count & " | "
        tot += count
        for lang in Lang:
          let langCount = model.byLang[lang][ngram]
          result.add $lang & " " & $langCount & " | "
          totByLang[lang] += langCount
        result.add "\n"
      result.add $tot & " | "
      for lang in Lang:
        result.add $lang & " " & $totByLang[lang] & " | "
      result.add "\n"
      result.add "---\n"

  echo model

nbSave