FROM ubuntu:latest
MAINTAINER Elliot Wright <hello@elliotdwright.com>

ARG NYLAS_SYNC_ENGINE_VERSION="17.3.8"

ENV MYSQL_HOST=mysql
ENV MYSQL_PORT=3306
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379

# @todo: Download zip version of sync engine from Github instead.

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        gettext-base \
        git-core \
        libssl-dev \
        sudo \
        wget \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/app/lists/* \
    && cd /opt \
    && wget https://github.com/nylas/sync-engine/archive/${NYLAS_SYNC_ENGINE_VERSION}.tar.gz \
        -O sync-engine.tar.gz \
    && tar xzvf ./sync-engine.tar.gz \
    && mv /opt/sync-engine-${NYLAS_SYNC_ENGINE_VERSION} /opt/sync-engine

RUN set -x \
    && export SUDO_UID=0 \
    && export SUDO_GID=0 \
    && cd /opt/sync-engine \
    # Hack to get around git commands being run in the setup script.
    && git init \
    && ./setup.sh -p \
    # Hack because for reason the one in the setup.sh doesn't work?
    && pip install --upgrade .

WORKDIR /opt/sync-engine/bin
