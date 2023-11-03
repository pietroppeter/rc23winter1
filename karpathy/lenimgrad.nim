type Value = object
  data: float

# I like this kind of initializer (I should review exi)
func init(T: typedesc[Value], data: float): Value =
  Value(data: data)

let a = Value.init(2.0)

echo a # (data: 2.0), no repr needed

# this is available by default
let b = Value(data: -3.0)

func `+`(a, b: Value): Value =
  Value(data: a.data + b.data)

echo a + b