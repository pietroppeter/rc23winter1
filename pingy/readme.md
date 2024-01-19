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
- running `nimble init`
- adding manually `mummy` as dependency (no `nimble add`)
- `fly launch` first time
- `fly deploy` next times
- is `fly` and `flyctl` the same?

```
==> Verifying app config
Validating /Users/pietroppeter/rc/rc23winter1/pingy/fly.toml
Platform: machines
✓ Configuration is valid
--> Verified app config
==> Building image
Remote builder fly-builder-sparkling-dew-8573 ready
Remote builder fly-builder-sparkling-dew-8573 ready
==> Building image with Docker
--> docker host: 20.10.12 linux x86_64
[+] Building 25.7s (9/9) FINISHED                                                      
 => [internal] load build definition from Dockerfile                              0.8s
 => => transferring dockerfile: 444B                                              0.7s
 => [internal] load .dockerignore                                                 0.5s
 => => transferring context: 2B                                                   0.5s
 => [internal] load metadata for docker.io/nimlang/nim:latest                     1.6s
 => [internal] load build context                                                 0.6s
 => => transferring context: 645B                                                 0.6s
 => [1/4] FROM docker.io/nimlang/nim:latest@sha256:22ca8382c03d339c967c966b7b373  0.0s
 => CACHED [2/4] WORKDIR /app                                                     0.0s
 => [3/4] COPY . /app                                                             0.0s
 => [4/4] RUN nimble c -d:release -y server                                      22.7s
 => exporting to image                                                            0.0s
 => => exporting layers                                                           0.0s
 => => writing image sha256:8454ced8ca2bbf4467db14eba9e2caa3609fa49366aa5b520107  0.0s
 => => naming to registry.fly.io/pingy-long-moon-805:deployment-01HMET2E3C9QTS65  0.0s
--> Building image done
==> Pushing image to fly
The push refers to repository [registry.fly.io/pingy-long-moon-805]
74de24a55fab: Pushed 
50074ced4948: Pushed 
f3d5036a9fa7: Pushed 
9ca4766385bc: Pushed 
c679612a20f3: Pushed 
49866ef73cc9: Pushed 
91367454c0b2: Pushed 
f5bb4f853c84: Pushed 
deployment-01HMET2E3C9QTS65MFDCNNJ9HA: digest: sha256:8bfe5fb0be9e2c32e5bc382c20ba3478c28897fdb6d3fe8bd3f93b1794a89587 size: 2001
--> Pushing image done
image: registry.fly.io/pingy-long-moon-805:deployment-01HMET2E3C9QTS65MFDCNNJ9HA
image size: 740 MB

Watch your deployment at https://fly.io/apps/pingy-long-moon-805/monitoring

Provisioning ips for pingy-long-moon-805
  Dedicated ipv6: 2a09:8280:1::4e:e8ce
  Shared ipv4: 66.241.125.68
  Add a dedicated ipv4 with: fly ips allocate-v4

This deployment will:
 * create 2 "app" machines

No machines in group app, launching a new machine

WARNING The app is not listening on the expected address and will not be reachable by fly-proxy.e 9080716a075587 [app] update finished: success
You can fix this by configuring your app to listen on the following addresses:
  - 0.0.0.0:8080
Found these processes inside the machine with open listening sockets:
  PROCESS        | ADDRESSES                              
-----------------*----------------------------------------
  /app/server    | 127.0.0.1:8080                         
  /.fly/hallpass | [fdaa:5:749b:a7b:d5a6:b363:5b97:2]:22  

Creating a second machine to increase service availability

-------
 ✖ Failed: error creating a new machine: failed to launch VM: To create more than 1 …
-------
Error: error creating a new machine: failed to launch VM: To create more than 1 machine per app please add a payment method. https://fly.io/dashboard/pietro-peterlongo/billing (Request ID: 01HMET8AE7R76MFD6CQT337CHZ-fra)
```
this time it seems it worked but I need to set up a payment method (even though I will use free account).
- after setting up payment method fly cli does not give error but app does not do what it should (show hello world)
- locally it runs using same commands as dockerfile
- will need to debug docker
- mmh seems to be a docker issue, something I am setting wrong? a port?
  - did `docker build -t pingy:latest .`
  - and `docker run -p 8080:8080 pingy`
  - says `Serving on http://localhost:8080` but nothing is shown


  I could clean up readme, tag this version and offer it as a simple example of how to deploy a nim app on fly. (publish on fly forum and nim forum)