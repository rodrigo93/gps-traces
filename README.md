# GPS Traces

This is a simple RESTful API to persist **collections of GPS points (collection in JSON format)**. These collections are called `traces`.

This is an example trace:
```json
[{ "latitude": 32.9377784729004, "longitude": -117.230392456055 },
{ "latitude": 32.937801361084, "longitude": -117.230323791504 },
{ "latitude": 32.9378204345703, "longitude": -117.230278015137 }]
```

# Stack

- Docker
- SQLite3
- Rails 6.0.0
- Ruby 2.6.5
- Rspec

## Tools

### Lints
#### Ruby

- [brakeman](https://github.com/presidentbeef/brakeman): static analysis security vulnerability scanner for Ruby on Rails applications (via [pronto-brakeman](https://github.com/prontolabs/pronto-brakeman))
- [fasterer](https://github.com/DamirSvrtan/fasterer): performance checker and suggester (via [pronto-fasterer](https://github.com/prontolabs/pronto-fasterer))
- [flay](https://github.com/seattlerb/flay): analyzes code for structural similarities (via [pronto-flay](https://github.com/prontolabs/pronto-flay))
- [reek](https://github.com/troessner/reek): code smell detector for Ruby (via [pronto-reek](https://github.com/prontolabs/pronto-reek))
- [rubocop](https://github.com/rubocop-hq/rubocop): Ruby static code analyzer and formatter, based on the community Ruby style guide (via [pronto-rubocop](https://github.com/prontolabs/pronto-rubocop))

#### Git

- [poper](https://github.com/mmozuras/poper): makes sure that your git commit messages are well-formed (via [pronto-poper](https://github.com/prontolabs/pronto-poper))


# Setup
For this project, we use Docker and docker-compose. So if you want to run this project,
be sure to have both installed before continuing.

You can follow [this tutorial](https://docs.docker.com/compose/install/) explaining how to install them.

# Running
All you need to do to run this project is running the following command in the root directory of this project:

```shell
$ docker-compose up
```

or, you can use:

```shell
$ dev/build
$ dev/start
```

Wait for the build and have fun! :D

PS: This might take some minutes, depending on you internet speed to download the necessary images.

# Available commands

> `dev/bash`

Open a bash session inside a temporary `gps_traces` container.

> `dev/build`

Build and run everything that is declared in `Dockerfile`.

> `dev/bundle-install`

Runs `bundle install` inside a temporary `gps_traces` container.

> `dev/bundle-update`

Runs `bundle update` inside a temporary `gps_traces` container. 

> `dev/console`

Open a `rails console` inside a container. By default it will open inside the `gps_traces` container.

> `dev/lint`

Run all configured lints in the project.

> `dev/logs`

Check log outputs from `gps_traces` container.

> `dev/restart`

Restarts all containers from this project.

> `dev/rspec FILE_PATH`

Run all RSpec tests or just the given specs passed in the `FILE_PATH` argument.

> `dev/start`

Start all containers from this project.

> `dev/stop`

Stop all containers from this project.

# Endpoints

## GET traces
- Route: `http://localhost:3000/api/v1/traces/<some-trace-id>`

- Example:
```
curl -X GET \
  http://localhost:3000/api/v1/traces/1 \
  -H 'cache-control: no-cache'
```

## PATCH traces
- Route: `http://localhost:3000/api/v1/traces/<some-trace-id>`

- Example:
```
curl -X PATCH \
  http://localhost:3000/api/v1/traces/1 \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Length: 226' \
  -H 'Content-Type: application/json' \
  -H 'Host: localhost:3000' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'coordinates=[{"latitude":40.780517578125,"longitude":-73.9483489990234}]'
```

## POST traces
- Route: `http://localhost:3000/api/v1/traces`

- Example:
```
curl -X POST \
  http://localhost:3000/api/v1/traces \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Length: 296' \
  -H 'Content-Type: application/json' \
  -H 'Host: localhost:3000' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'coordinates=[{ "latitude": 32.937931060791, "longitude": -117.229949951172 },{ "latitude": 32.9379615783691, "longitude": -117.229919433594 }]'
```

## PUT traces
- Route: `http://localhost:3000/api/v1/traces/<some-trace-id>`

- Example:
```
curl -X PUT \
  http://localhost:3000/api/v1/traces/1 \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'coordinates=[{"latitude":40.780517578125,"longitude":-73.9483489990234}]'
```

## DELETE traces
- Route: `http://localhost:3000/api/v1/traces/<some-trace-id>`

- Example:
```
curl -X DELETE \
  http://localhost:3000/api/v1/traces/1 \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Length: 0' \
  -H 'Content-Type: multipart/form-data; boundary=--------------------------787690893027824478654983' \
  -H 'Host: localhost:3000' \
  -H 'cache-control: no-cache'
```
