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

### step 2 - deploy to fly.io

- there is standing question: https://community.fly.io/t/how-to-deploy-a-nim-app-to-flyio/6591
- points to official docker image: https://hub.docker.com/r/nimlang/nim
- another option (will not pursue) is PMunch's article (not using docker but using a VM): https://peterme.net/setting-up-a-nim-server-for-dummies.html
- reading documentation I will need a regular image but I will go with default `nimlang/nim` namespace for the moment (should use lates nim and regular which means nim compiler and nimble)
- asked chatGpt about dockerfile, now it is good. it appears I do not have a working docker installation, so I will skip that and try to go directly with fly.io
