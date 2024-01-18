impossible stuff day

goals:
- deploy a web server that can use websockets on fly.io
- first steps: install and use mummy, try to run the examples there
- stretch goal: each client has a ping button and sees ping request of other connected clients. pings are random emojis? maybe emoji is set on first connection?

## step 1 - basic http server

- a working nim (my current version 1.6.10, it's old! last compiled in Dec 2022!)
- `nimble install mummy`
- created a `nim.cfg` with `--threads:on --mm:orc`
- run with `nim r server`
- `open http://localhost:8080`
