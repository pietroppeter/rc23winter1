# simpleset byte pair encoing, no tokenization, no special tokens
import std / tables
import print
let words = @["cat", "hat", "had", "bat", "made", "mad", "sad"]

type
  Frequencies = CountTable[string]

func initBpe(words: seq[string]): Frequencies =
  for word in words:
    for c in word:
      result.inc $c

print initBpe words


