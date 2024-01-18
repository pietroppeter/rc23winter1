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
- following instructions from gleam website
- `brew install flyctl`
- `fly auth signup` and connected my github account

```
❯ flyctl launch  
Scanning source code
Detected a Dockerfile app
Creating app in /Users/pietroppeter/rc/rc23winter1/pingy
We're about to launch your app on Fly.io. Here's what you're getting:

Organization: Pietro Peterlongo          (fly launch defaults to the personal org)
Name:         pingy                      (derived from your directory name)
Region:       Johannesburg, South Africa (this is the fastest region for you)
App Machines: shared-cpu-1x, 1GB RAM     (most apps need about 1GB of RAM)
Postgres:     <none>                     (not requested)
Redis:        <none>                     (not requested)
? Do you want to tweak these settings before proceeding? No
Created app 'pingy' in organization 'personal'
Admin URL: https://fly.io/apps/pingy
Hostname: pingy.fly.dev
Wrote config file fly.toml
Validating /Users/pietroppeter/rc/rc23winter1/pingy/fly.toml
Platform: machines
✓ Configuration is valid
==> Building image
Remote builder fly-builder-sparkling-dew-8573 ready
Remote builder fly-builder-sparkling-dew-8573 ready
==> Building image with Docker
--> docker host: 20.10.12 linux x86_64
[+] Building 12.7s (8/8) FINISHED                                                      
 => [internal] load build definition from Dockerfile                              0.7s
 => => transferring dockerfile: 441B                                              0.7s
 => [internal] load .dockerignore                                                 0.5s
 => => transferring context: 2B                                                   0.5s
 => [internal] load metadata for docker.io/nimlang/nim:latest                     3.3s
 => [internal] load build context                                                 0.6s
 => => transferring context: 3.41kB                                               0.6s
 => [1/4] FROM docker.io/nimlang/nim:latest@sha256:22ca8382c03d339c967c966b7b373  8.1s
 => => resolve docker.io/nimlang/nim:latest@sha256:22ca8382c03d339c967c966b7b373  0.0s
 => => sha256:99570ab6b63553dc545f7042ff4e26cf5ea3d550338671 149.88MB / 149.88MB  3.0s
 => => sha256:3749235b3486a98b426ed3c585d7052eb2db4966f7c1363db1 4.95MB / 4.95MB  2.7s
 => => sha256:15fdf3042b35d9ee5095f811176d7ff821f67cd013d9120a 41.93MB / 41.93MB  3.6s
 => => sha256:80ba25ed7eb4ab4f4b8fcdcf04d7b1ab73429843903e7904 26.47MB / 26.47MB  3.1s
 => => sha256:22ca8382c03d339c967c966b7b373fa8735f49f744ee9cf52e 1.38kB / 1.38kB  0.0s
 => => sha256:9f2a652bf8cef42fe0cb7c524720e1b210d758703b52021778 4.09kB / 4.09kB  0.0s
 => => sha256:01085d60b3a624c06a7132ff0749efc6e6565d9f2531d768 27.51MB / 27.51MB  1.8s
 => => extracting sha256:01085d60b3a624c06a7132ff0749efc6e6565d9f2531d7685ff559f  0.9s
 => => extracting sha256:99570ab6b63553dc545f7042ff4e26cf5ea3d550338671750dfc7e5  3.0s
 => => extracting sha256:3749235b3486a98b426ed3c585d7052eb2db4966f7c1363db13222e  0.2s
 => => extracting sha256:15fdf3042b35d9ee5095f811176d7ff821f67cd013d9120a62a9c83  0.9s
 => => extracting sha256:80ba25ed7eb4ab4f4b8fcdcf04d7b1ab73429843903e79048283002  0.7s
 => [2/4] WORKDIR /app                                                            0.1s
 => [3/4] COPY . /app                                                             0.0s
 => ERROR [4/4] RUN nimble c -d:release server                                    0.2s
------
 > [4/4] RUN nimble c -d:release server:
#0 0.231      Error: Could not find a file with a .nimble extension inside the specified directory: /app
------
Error: failed to fetch an image or build from source: error building: failed to solve: executor failed running [/bin/sh -c nimble c -d:release server]: exit code: 1

```