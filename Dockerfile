FROM python:3.6-slim

WORKDIR /app

ENV \
  # Disable buffered output
  PYTHONUNBUFFERED=1 \
  # pip enhancements
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_NO_CACHE_DIR=off

# git is required for pre-commit
RUN apt-get update && apt-get install -y git --no-install-recommends && rm -rf /var/lib/apt/lists/*

ADD requirements.txt .
# Some Python dependencies require compilation
# g++ is shared between multiple dependencies
# libyaml-dev is for PyYAML
RUN set -ex \
  && buildDeps=' \
    g++ \
    libyaml-dev \
  ' \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && pip install --no-compile -r requirements.txt \
  && apt-get purge -y --auto-remove $buildDeps

ADD .pre-commit-config.yaml .
RUN pre-commit install

ADD . .
