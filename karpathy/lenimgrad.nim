type
  ValueKind = enum Atom, Op
  OpKind = enum Plus = "+", Times = "*" 
  Value* = ref object
    data*: float
    case kind: ValueKind
    of Atom:
      discard
    of Op:
      op: OpKind
      left: Value
      right: Value

func `+`*(a, b: Value): Value =
  Value(data: a.data + b.data, kind: Op, op: Plus, left: a, right: b)

func `*`*(a, b: Value): Value =
  Value(data: a.data * b.data, kind: Op, op: Times, left: a, right: b)

when isMainModule:
  import print # goody from treeform, should be in stdlib

  let a = Value(data: 2.0)

  # echo a #-> (data: 2.0)
  print a #-> a=Value(data: 2.0)

  let b = Value(data: -3.0)
  print a + b #-> a + b=Value(data: -1.0)

  let c = Value(data: 10.0)

  print (let d = (a*b) + c; d) # walrus like semantic for free
  #-> let d = (a * b) + c
  #-> d=Value(data: 4.0)

  #[after refactoring:

  a=Value:ObjectType(data: 2.0, kind: "Atom")
  a + b=Value:ObjectType(
    data: -1.0,
    kind: "Op",
    op: "+",
    left: Value:ObjectType(data: 2.0, kind: "Atom"),
    right: Value:ObjectType(data: -3.0, kind: "Atom")
  )

  let d = (a * b) + c
  d=Value:ObjectType(
    data: 4.0,
    kind: "Op",
    op: "+",
    left: Value:ObjectType(
      data: -6.0,
      kind: "Op",
      op: "*",
      left: Value:ObjectType(data: 2.0, kind: "Atom"),
      right: Value:ObjectType(data: -3.0, kind: "Atom")
    ),
    right: Value:ObjectType(data: 10.0, kind: "Atom")
  )

  ]#
