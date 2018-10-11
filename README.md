# Spectrum (White Label)

[![pipeline status](https://gitlab.com/ggclabs/spectrum/backendbadges/dev/pipeline.svg)](https://gitlab.com/ggclabs/spectrum/backend/commits/dev)
[![coverage report](https://gitlab.com/ggclabs/spectrum/backendbadges/dev/coverage.svg)](https://gitlab.com/ggclabs/spectrum/backend/commits/dev)

A Rails API with Postgresql. AWS SERVICE: `API-CORE-RAILS`. This API is a synchronous, HTTP driven, RESTful api. There are some RPC endpoints available. Checkout the Swagger documentation for more information.

## Setup

Welcome to the project! To start coding, first, install docker on your machine. Instruction can be found [here](https://docs.docker.com/engine/installation/) for different OSes.

We recommend using plis, a small docker-compose wrapper that reduces the pain of managing multiple project with docker-compose. You can read instructions on how to install it [here](https://github.com/IcaliaLabs/plis).

We also recommend to have node installed in your machine. Inside the repository, run `npm i` to install development dependencies. This will add husky to the project, which provides a easy way to setup git hooks. The prepush hook will automatically run rubocop on your machine to check if all files are correctly formatted. To install rubocop, run `gem install rubocop` in the project root folder.

After installing _plis_, you can optionally copy `.env.example` to a `.env` file on the project root folder. Mainly, all environment for development is already defined on docker-compose.yml, but you can customize it further through our own `.env` file.

Than build the application as follows:

```bash
plis build app
```

## Adding New Gems

- Add the gem in gemfile
- Reboot the application service

_Guidelines for adding new Gems_:

> For dependencies using system software, add the necessary packages into the Dockerfile and dev.Dockerfile.
> Check if dependencies exist on alpine linux.
> Check deployment requirements for adding new libraries.
> Avoid adding libraries to solve small problems.

## Docker

For development, we're using dev.Dockerfile, which itself uses ruby 2.4.2. For staging and production environments, we're using a new version of our current ruby images, which is mainly using version 2.4.3 and do not load a series of dependencies, which makes image size by about 25% the size of the 2.4.2 version. DO NOT CHANGE the Dockerfile image.

## AWS Engine Support in Docker Compose

On docker-compose, always reference the same software version used on Aws for both redis and psql.

_Currently, we're using_:

- Redis
  - 3.2.10
- Postgresql
  - 9.5.10

> Note that the base image uses postgresql-9.5.10-r0, which is identical to the current version.
When upgrading the Postgresql version, remove the volume associated with it.
Postgresql does not allow different versions to use the same associated data directory.

To remove the volume:

```sh
# Get the volume name (it will be something like project_postgres-data)
docker volume ls
```

```sh
# Remove the associated volume
docker volume rm project_postgres-data
```

## Code Style

We are using Rubocop to enforce best practices within our codebase. To ensure you have a fluid experience with the source code, install an extension to your current development environment that will auto-lint and auto-correct your code. All merge requests will be linted against our rubocop rules.

- VS_CODE: [vscode-ruby-rubocop](https://github.com/misogi/vscode-ruby-rubocop)
- ATOM: [linter-rubocop](https://atom.io/packages/linter-rubocop)
- SUBLIME: [SublimeLinter-rubocop](https://github.com/SublimeLinter/SublimeLinter-rubocop)

## Cheat Sheet

Useful commands for handling this project:

| Task               | Description                                                                                                                         | Command                            | URL                                                                       |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------|------------------------------------|---------------------------------------------------------------------------|
| Boot the server    | Runs the API Service with all binds enabled. The service will be available at localhost:80.                                         | `plis start app`                   | [Api Core Rails](http://localhost)                                        |
| Attach to server   | Binds local tty with container tty. CMD+C or CTRL+C within an attached container will stop the container.                           | `plis attach app`                  | -                                                                         |
| Running console    | Starts a new rails console in a separate container, without network bindings.                                                       | `plis run app bundle exec rails c` | -                                                                         |
| Running terminal   | Runs an ash process within a container, useful for inspecting files inside the container.                                           | `plis run app /bin/ash`            | -                                                                         |
| Continuous testing | Boots a guard process that will track files and re-run tests upon change.                                                           | `plis run guard`                   | -                                                                         |
| Single test        | Runs RSpec and stop the process.                                                                                                    | `plis run specs`                   | -                                                                         |
| Mailer Preview     | Runs mailcatcher, which will sniff outgoing e-mails and redirect them to a local inbox. Also, templates can be seen in the browser. | `plis start app`                   | [Mailers](http://localhost/rails/mailers)  [Inbox](http://localhost:1080) |
| Api Docs           | Runs the server and displays swagger documentation for API.                                                                         | `plis start app`                   | [Api Docs](http://localhost/docs)                                         |

> You can regenerate this table at [Tables Generator](https://www.tablesgenerator.com/markdown_tables).

## Known Issues

- Devise Token Auth randomly generates user tokens that do not properly deserialize. You can read more [here](https://github.com/lynndylanhurley/devise_token_auth/issues/121). The currently solution is in using devise-token-auth with 0.1.43.beta1 version, which fixes this issue for the moment.
