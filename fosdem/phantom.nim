# phantmom types in Nim
# inspired by Hayleigh's talk about Phantom types in Gleam
# the key ingredient for Nim is constraining the generic to a static type
# (thanks PMunch)
# unclear how this would work if you have many optional options...
import std / options

type ButtonKind = enum NoIcon, WithIcon

type Button[T: static ButtonKind] = object
  label: string
  icon: Option[string]

func initButton(label: string): Button[NoIcon] =
  result.label = label

func withIcon(button: Button[NoIcon], icon: string): Button[WithIcon] =
  result.label = button.label # do I need to do that? converting as:
  # result = button.Button[WithIcon] # does not work...
  result.icon = some(icon)


echo initButton("Hi").withIcon("👋")

assert not compiles(initButton("Hi").withIcon("👋").withIcon("❌"))
