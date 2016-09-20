# Python project boilerplate
This project provides a basic boilerplate for Python projects.


# Features
* Docker and Docker Compose. The image has been slimmed down as much as possible for a great starting point.
* Python 3.6. Easily swap out to Python 2, pypy or any other version by changing the `Dockerfile`.
* Linting with pre-commit, flake8, pylint, isort and pep257. An editorconfig is also provided.
* Test coverage ready.
* GitLab CI and Travis CI configs.
* Dependency pinning with hashes via pip tools (pip compile).

## Setup
This project is designed to be run in Docker, with Docker Compose during development. Your code directory is mounted by Docker Compose.

```sh
git clone ...
cd ...
docker-compose build
```

To start a Python shell:

```sh
docker-compose run --rm app
```

To start a Bash shell:

```sh
docker-compose run --rm app bash
```

You may want to make an alias:

```sh
alias dcr='docker-compose run --rm app'
dcr bash
```

## Running tests and linters
```sh
docker-compose run --rm app coverage run ...
docker-compose run --rm app pre-commit run --all-files
```

To configure the pre-commit hooks in a new git repo:
```sh
docker-compose run app pre-commit install-hooks
```

## Updating dependencies
Exact dependency versions are maintained using `pip-compile` from `pip-tools`.

```sh
docker-compose run --no-deps --rm app pre-commit autoupdate
docker-compose run --no-deps --rm app pip-compile requirements.in --no-header --generate-hashes --upgrade
```

## Committing with pre-commit hooks
The pre-commit hooks run inside Docker, but you may wish to commit in your OS instead.

Run the linters and commit bypassing hooks:

```sh
docker-compose run --no-deps --rm app ./git/hooks/pre-commit && git commit -n
```
