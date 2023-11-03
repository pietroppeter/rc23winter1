type Value* = object
  data*: float

func `+`*(a, b: Value): Value =
  Value(data: a.data + b.data)


func `*`*(a, b: Value): Value =
  Value(data: a.data * b.data)

when isMainModule:
  import print # goody from treeform, should be in stdlib

  let a = Value(data: 2.0)

  echo a #-> (data: 2.0)
  print a #-> a=Value(data: 2.0)

  let b = Value(data: -3.0)
  print a + b #-> a + b=Value(data: -1.0)

  let c = Value(data: 10.0)

  print (let d = (a*b) + c; d) # walrus like semantic for free
  #-> let d = (a * b) + c
  #-> d=Value(data: 4.0)
