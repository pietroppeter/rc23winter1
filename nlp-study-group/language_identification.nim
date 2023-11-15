import nimib

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

nbSave