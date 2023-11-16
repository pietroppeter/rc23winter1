# implementing a regular expression engine

this is my target for first impossible day (W3D4)

goals is to implement some features of a regular expression engine
using finite automata.
This is an inspiring reference I found: https://swtch.com/~rsc/regexp/

To start I decide to skip for the moment finite automata
and implement in Nim this famous beatiful code:
https://www.cs.princeton.edu/courses/archive/spr09/cos333/beautiful.html

## a regular expression matcher

dev notes:

- [x] intro
- [x] type safety section
- [x] only literal and wildcard
- [x] deploy rc23winter1 to github pages: https://pietroppeter.github.io/rc23winter1/regexes/a_regular_expression_matcher.html
- [ ] trillion words corpus? see http://norvig.com/ngrams/
- [ ] find matches for re"r...r..""
- [ ] complete implementation
- [ ] use it to help me solve wordle today (no spoiler, folder)
- [ ] do also kleene +?
- [ ] simple regex?

useful tips for me when working at edge of my abilities for hard stuff:
- motivate with people (Kleene!)
- motivate with simple test cases (r3r2)
- reduce to the essential (only literals and wildcard)
- even with only essential motivate with applications (wordle!)
- start "boring", skip the most fascinating parts (finite automata)
