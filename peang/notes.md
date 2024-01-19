## pairing with Elias

- found out we need new `type` keyword
- release note for the change: https://gleam.run/news/v0.32-polishing-syntax-for-stability/
- we can suggest to improve error message for that
- we tested our server with `curl -X POST -d "hi" localhost:3000/echo`
- w
---

impossible stuff day project

## step 0

decide on first step

- first to unblock, follow hello gleam on fly: https://gleam.run/deployment/fly/

refs (adding them here):
- https://github.com/rawhat/glisten
- https://github.com/rawhat/mist

## step 1

### 1.1 first issue: old gleam!

- first issue, need to update gleam

```
The package gleeunit requires a Gleam version satisfying >= 0.33.0 but you are using v0.32.4.
```

- how do I update gleam? looked for the command in release notes, not found
- I think it is installation dependent. In my case: `brew upgrade gleam` (after running `brew update`)
- wow it has a lot of dependencies! (Upgrading 20 dependents of upgraded formulae). numpy, libsodium, mpdecimal, imagemagick, also upgrading python! Hey but no, this is all due to brew and I can disable it (but having it by default on is... mmmh, maybe it is good, do not know)

### 1.2 fixed first issue, install deps

- anyway, now I do not have anymore issues.
- running `gleam test` to check
- ah, now I have lots of deprecations and warnings from glisten and mist, will they keep appearing?
- If I run right away `gleam test` again, no they do not

### 1.3 copy and paste example code

- new issue, mist does not have `run_service` value (anymore)
- by poking around in the code, I see there are commits that fix glisten warnings and probably also mist ones
- still have to understand where run_service has disappeared
- ok disappeared in 0.13.0, last seen in 0.12.0
- we are going with wisp
- created a button inside a form
- issue: unicode is messed up through string_builder
  - we will solve this later
- we were able to make fail the unimplemented (todo) POST request
- looked into use: https://gleam.run/book/tour/use.html
  - introduced in Nov 2022: https://gleam.run/news/v0.25-introducing-use-expressions/
- and equivalent in roc https://www.roc-lang.org/tutorial#backpassing
  - consider removing: https://docs.google.com/document/d/1mTEZlOKqtMonmVsIGEC1A9ufs1TQHhVgZ52Vn-13GeU/edit
- handle form in a simple way

### 1.4 let's try to copy and paste more recent usage code from mist

- copying and pasting from most recent mist's readme, new issue
```
The module `mist` does not have a `Connection` value.
```
- this is bizarre since I can see the Connection type in mist source code (even checking the version I should have): https://github.com/rawhat/mist/blob/v0.15.0/src/mist.gleam#L35

## Appendix A: shell outputs

### Deprecation outputs after installing dependencies


```
  Compiling glisten

warning: Deprecated type used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/socket/options.gleam:39:44
   │
39 │ pub fn to_map(options: List(TcpOption)) -> Map(atom.Atom, Dynamic) {
   │                                            ^^^^^^^^^^^^^^^^^^^^^^^ This type has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/socket/options.gleam:61:9
   │
61 │   |> map.from_list
   │         ^^^^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/socket/options.gleam:80:9
   │
80 │   |> map.merge(overrides)
   │         ^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/socket/options.gleam:81:9
   │
81 │   |> map.to_list
   │         ^^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/ssl.gleam:62:9
   │
62 │   |> map.to_list
   │         ^^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated type used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/tcp.gleam:42:39
   │
42 │ pub fn socket_info(socket: Socket) -> Map(a, b)
   │                                       ^^^^^^^^^ This type has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/tcp.gleam:62:9
   │
62 │   |> map.to_list
   │         ^^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated type used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/socket/transport.gleam:33:17
   │
33 │   fn(Socket) -> Map(Atom, Dynamic)
   │                 ^^^^^^^^^^^^^^^^^^ This type has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated type used
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/socket/transport.gleam:129:39
    │
129 │ pub fn socket_info(socket: Socket) -> Map(a, b)
    │                                       ^^^^^^^^^ This type has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Inexhaustive patterns
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/handler.gleam:141:7
    │  
141 │ ╭       case msg {
142 │ │         Internal(TcpClosed) | Internal(SslClosed) | Internal(Close) ->
143 │ │           case state.transport.close(state.socket) {
144 │ │             Ok(Nil) -> {
    · │
196 │ │         }
197 │ │       }
    │ ╰───────^

This case expression does not have a pattern for all possible values.
If is run on one of the values without a pattern then it will crash.

The missing patterns are:

    Internal(Ssl(_, _))
    Internal(Tcp(_, _))

In a future version of Gleam this will become a compile error.


warning: Unreachable case clause
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/glisten/src/glisten/acceptor.gleam:85:9
   │  
85 │ ╭         msg -> {
86 │ │           logger.error(#("Unknown message type", msg))
87 │ │           actor.Stop(process.Abnormal("Unknown message type"))
88 │ │         }
   │ ╰─────────^

This case clause cannot be reached as a previous clause matches
the same values.

Hint: It can be safely removed.
  Compiling mist

warning: Inexhaustive patterns
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/encoder.gleam:32:3
   │  
32 │ ╭   case status {
33 │ │     100 -> <<"Continue":utf8>>
34 │ │     101 -> <<"Switching Protocols":utf8>>
35 │ │     103 -> <<"Early Hints":utf8>>
   · │
86 │ │     511 -> <<"Network Authentication Required":utf8>>
87 │ │   }
   │ ╰───^

This case expression does not have a pattern for all possible values.
If is run on one of the values without a pattern then it will crash.

The missing patterns are:

    _

In a future version of Gleam this will become a compile error.


warning: Deprecated type used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:74:12
   │
74 │   headers: Map(String, String),
   │            ^^^^^^^^^^^^^^^^^^^ This type has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated type used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:75:15
   │
75 │ ) -> Result(#(Map(String, String), BitArray), DecodeError) {
   │               ^^^^^^^^^^^^^^^^^^^ This type has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:392:8
    │
392 │     map.from_list([
    │        ^^^^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:401:12
    │
401 │         map.insert(defaults, key, value)
    │            ^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:404:11
    │
404 │     |> map.to_list
    │           ^^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:81:13
   │
81 │       |> map.insert(field, value)
   │             ^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:241:12
    │
241 │         map.new(),
    │            ^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Deprecated value used
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/http.gleam:262:59
    │
262 │       Ok(request.Request(..req, query: query, headers: map.to_list(headers)))
    │                                                           ^^^^^^^^ This value has been deprecated

It was deprecated with this message: Please use the `gleam/dict`
module instead

warning: Inexhaustive patterns
   ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/websocket.gleam:45:3
   │  
45 │ ╭   case data {
46 │ │     <<>> -> resp
47 │ │     <<masked:bits-size(8), rest:bits>> -> {
48 │ │       let assert Ok(mask_value) = list.at(masks, index % 4)
   · │
51 │ │     }
52 │ │   }
   │ ╰───^

This case expression does not have a pattern for all possible values.
If is run on one of the values without a pattern then it will crash.

The missing patterns are:

    _

In a future version of Gleam this will become a compile error.


warning: Inexhaustive patterns
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/websocket.gleam:110:17
    │  
110 │ ╭                 case complete {
111 │ │                   1 -> #(Complete(frame), rest)
112 │ │                   0 -> #(Incomplete(frame), rest)
113 │ │                 }
    │ ╰─────────────────^

This case expression does not have a pattern for all possible values.
If is run on one of the values without a pattern then it will crash.

The missing patterns are:

    _

In a future version of Gleam this will become a compile error.


warning: Unreachable case clause
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist/internal/websocket.gleam:417:5
    │
417 │     _, _ -> actor.Stop(process.Abnormal("Unexpected frame type or user state"))
    │     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This case clause cannot be reached as a previous clause matches
the same values.

Hint: It can be safely removed.

warning: Inexhaustive patterns
    ┌─ /Users/pietroppeter/rc/rc23winter1/peang/build/packages/mist/src/mist.gleam:407:3
    │  
407 │ ╭   case msg {
408 │ │     Internal(Data(TextFrame(_length, data))) -> Text(data)
409 │ │     Internal(Data(BinaryFrame(_length, data))) -> Binary(data)
410 │ │     User(msg) -> Custom(msg)
411 │ │   }
    │ ╰───^

This case expression does not have a pattern for all possible values.
If is run on one of the values without a pattern then it will crash.

The missing patterns are:

    Internal(Continuation(_, _))
    Internal(Control(_))

In a future version of Gleam this will become a compile error.

   Compiled in 9.04s
    Running peang_test.main
.
Finished in 0.009 seconds
1 tests, 0 failures
```
