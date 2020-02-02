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
- SQLite
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
_TODO_

## Downloading and installation
_TODO_

# Running
_TODO_

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
_TODO_

## PATCH traces
_TODO_

## POST traces
_TODO_

## PUT traces
_TODO_

## DELETE traces
_TODO_
