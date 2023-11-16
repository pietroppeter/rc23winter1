import nimib

nbInit
nbText: """
## "A Regular Expression Matcher" in Nim

> Work in Progress!

An implementation in Nim of
the minimal regular expression matcher from
an article by Brian Kernighan explaining code by Rob Pike:
[A Regular Expression Matcher](https://www.cs.princeton.edu/courses/archive/spr09/cos333/beautiful.html)
(I suspect it is an excerpt from the book Beatiful Code by Andy Oram and Greg Wilson).

Minimality is due to the fact that only 5 common regular expression features are implemented:

| Pattern | Description |
|---|---|
| c | matches any literal character c |
| . | matches any single character |
| ^ | matches the beginning of the input string |
| $ | matches the end of the input string |
| * | matches zero or more occurrences of the previous character |

The article is a great read and the implementation is in C.
Porting to Nim let's me appreciate differences with Nim
(pointers! null terminated strings!).

Let's start with a bit of type safety.
None of this code is needed in the original,
but it makes sense in Nim to take advantage of these nice features:
- `distinct` types
- generalized raw string literals
- the special `$` proc
"""
nbCode:
  type RegExp = distinct string # I know it is a string, the compiler does not

  func re(pattern: string): RegExp = pattern.RegExp

  func `$`(regexp: RegExp): string = "re" & '"' & regexp.string & '"'

  func high(regexp: RegExp): int {. borrow .}

   # {. borrow .} here does not work, not sure why
  func `[]`(regexp: RegExp, i: int): char = regexp.string[i]

  let r3r2Pattern = re"r...r.." # same as re(r"r...r..")

  echo r3r2Pattern # automatically calls `$` proc
  echo r3r2Pattern[4]
nbText: """How many seven letters word there are in English
that start with rec and have a r in 5th place?

With the above regular expression, the engine and a list of words in English
I could find the answer (on the top of my head I can think of two).

I would also find words that contain such a subword,
since the regular expression does not contain the anchors `^` and `$`.

Let's start by implementing only the first two features
needed for the above regular expression:
literal and wildcard.
"""
nbCode:
  func match(regexp: RegExp, text: string; i, j: int): bool =
    ## true if regexp starting from i matches text starting from j
    # debugEcho "i: ", i, " j: ", j
    if i > regexp.high:
      # debugEcho "no more regex to match"
      true # no more regexp to match
    elif j < text.len and (regexp[i] == '.' or regexp[i] == text[j]):
      # there is text available and wildcard or literal match
      # debugEcho "text available and wildcard or literal match"
      regexp.match(text, i + 1, j + 1) # recursive!
    else:
      false

  func match(regexp: RegExp, text: string): bool =
    for j in 0 .. text.high:
      if regexp.match(text, 0, j):
        return true
    # default is false

  # some tests 
  assert re".u.".match "run"
  assert re"s.a.".match "space"
  assert re"s.a.".match "fiscal"
  assert not re"s.a.".match "sane"
  assert re"".match "anything"
  assert not re".".match ""
nbText: """
Differences with original code:
- we are not using pointers so we need to keep track of indices `i` and `j`
- we use overloading, our match function with indices is equivalent to `matchhere`
- strings are not null terminated (and we can iterate over their length)

Note that:
- it is **11 lines of code** and already useful!
- I left the `debugEcho` commented since I did have a bug (`j > text.len` instead of `j < text.len`)
- need to use `debugEcho` instead of `echo` because we are inside a function
  and no side effects are permitted (but `debugEcho` gets a pass from compiler)
"""

# http://norvig.com/ngrams/

#[
  func match(regexp: RegExp, text: string, i: int): bool =
    discard

  func match(regexp: RegExp, text: string): bool =
    var i == 0
    if regexp[0] == '^':
      return match(regexp, text, i)
    else:
      for i 

]#

nbSave