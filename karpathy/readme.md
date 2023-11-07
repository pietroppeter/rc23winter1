notes and code while following Karpathy's
[Neural Networks: Zero to Hero](https://karpathy.ai/zero-to-hero.html)

## 1 The spelled-out intro to neural networks and back propagation

2h25'video

### derivatives

nice to have: interactive document

### micrograd

lenimgrad
- [x] minimial value, init and echo
  - vs python: in nim you get a decent default repr and init
  - no need to use a class
- [x] add value
  - vs python: more natural operator definition `+` (and no need to attach to class, again)
- [x] multiply
  - vs python: showing a walrus like operator we get for free
- vs python: up to now the most odd thing we have notation wise is oberon's `*` operator for exporting (instead of pub keyboard or everything public and underscore means private convention as in python)
- [x] children and op
  - vs python: need to refactor Value in ref object
  - I like the enums Op and ValueKind
  - print does a great job at visualizing this things
- graph, skipping for now
  - [ ] I could use mermaid in nimib
- label, skipping for now
  - [ ] could use metaprogramming to avoid needing to specify label
- PAUSE: stopped watching after explaining manual grad (and before the neuron)
https://youtu.be/VMj-3S1tku0?si=kmf-l2pZsRmplNvw&t=3182
- continued watching, to implement first:
  - _backward (i still need to implement grad)
    - not trivial to understand which type is this!
  - topolgical sort
  - backward: apply topological sort to _backward
    - watch out for bug
- then there is the clean up and we shoudl implement:
  - add and mul constant
    - and we can do it with symmetry! (no need about __rmul__)
  - exp
  - division? no power!
  - neg and sub
  - check equivalence of gradient of tanh as broken down as exp
- finally it uses pytorch to do the same
  - how does it look with kears 3.0 aka core?
- PAUSE again before building the MLP: https://youtu.be/VMj-3S1tku0?si=gcxxz5kzFPBv18ds&t=6252 (watched 50'of content)


inspiration: I should have a `nb` command from nimib that when it is run against a nim file it decorates it with outputs
(if I add also a shortcut from editor it would make a pretty nice DX)
