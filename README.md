# Customised [Hydra Hot Potato Player game][hydra-hpp]

## Get the source code

```
$ git clone https://github.com/cjus/hydra-hpp.git <target-directory>/hydra-hpp/service
```
I cloned the source into the `service` sub-directory as I want to use my own scripts for starting instances using [Docker][docker]. I then copied my scripts into the `hydra-hpp` directory:

```
$ cd <target-directory>
$ cp -r ./HydraTest/scripts ./hydra-hpp/
$ cp -r ./HydraTest/docker ./hydra-hpp/
```
I then adjusted the scripts to suit the hpp application:

```
$ rm -rf ./hydra-hpp/scripts/create-hello-service.exp
```

 - Edit line 6 of `<target-directory>/hydra-hpp/scripts/hydra-cli-config.sh` to read `hydra-cli config hpp << ANSWERS`
 - Add the following scripts to `package.json`:
 
   ```
    "john": "node hpp.js John true",
    "susan": "node hpp.js Susan",
    "jane": "node hpp.js Jane",
    "docker:up:single": "cd ../docker && echo \"NODE_ENV=local\r\nMODE=single\" > .env && docker-compose up single",
    "docker:start:single": "cd ../docker && echo \"NODE_ENV=local\r\nMODE=single\" > .env && docker-compose start single",
    "docker:stop:single": "cd ../docker && docker-compose stop single",
    "docker:up": "cd ../docker && echo \"NODE_ENV=local\r\nMODE=multi\" > .env && docker-compose up",
    "docker:start": "cd ../docker && echo \"NODE_ENV=local\r\nMODE=multi\" > .env && docker-compose start",
    "docker:stop": "cd ../docker && docker-compose stop",
    ```
 - Edit `startup.sh`
 - Edit `<target-directory>/hydra-hpp/service/config/config.json` and set `redis:url` to `redis`, `redis:port` to `6379` and `service:port` to `6510`. Also, set `hydra.servicePort` to `0` so that the port is chosen randomly (if a port is allocated all services started on the same machine will have the same ID - since the service ID is based on the port - which means they won't be registered as separate services and hpp will fail).
 - Edit `hpp.js` so that it works with my version of Node:
  - Add `const readline = require('readline');`
  - Change `process.stdout.clearLine();` to `readline.clearLine(process.stdout, 0)`
  - Change `process.stdout.cursorTo(0);` to `readline.cursorTo(process.stdout, 0)`
 - Add `parallel` package to `Dockerfile` so that I can run several instances of node at once (for single container play).

## Run the code in a single Docker instance

To create the container:

```
$ cd <target-directory>/hydra-hpp/service
$ npm run docker:up:single
.
.
.
$ npm run docker:stop:single
$ 
```

To run an existing container:

```
$ cd <target-directory>/hydra-hpp/service
$ npm run docker:start:single
$ docker logs -f docker_hpp-single_1
```

## Run the code in multiple Docker instances

Open separate terminal windows and type in each:

```
$ cd <target-directory>/hydra-hpp/service
$ npm run docker:up/start <player_name> {<start_player>}
```

 [hydra-hpp]: https://github.com/cjus/hydra-hpp
 [docker]: https://www.docker.com/