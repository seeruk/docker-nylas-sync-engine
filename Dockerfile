FROM ubuntu:latest
MAINTAINER Elliot Wright <hello@elliotdwright.com>

ARG NYLAS_SYNC_ENGINE_VERSION="17.3.8"

ENV MYSQL_HOST=mysql
ENV MYSQL_PORT=3306
ENV MYSQL_USER=nylas
ENV MYSQL_PASS=nylas
ENV MYSQL_SCHEMA=inbox
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379

ADD config.json.tpl /opt/nylas-setup/config.json.tpl
ADD secrets.yml.tpl /opt/nylas-setup/secrets.yml.tpl
ADD docker-entrypoint.sh /opt/nylas-setup/docker-entrypoint.sh

# inbox-api
EXPOSE 5556
# inbox-start
EXPOSE 16384

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

RUN set -x \
    && groupadd -g 1000 nylas \
    && useradd -m -u 1000 -g 1000 nylas \
    && chown -R nylas:nylas /etc/inboxapp \
    && chown -R nylas:nylas /var/log/inboxapp \
    && chown -R nylas:nylas /var/lib/inboxapp \
    && chmod +x /opt/nylas-setup/docker-entrypoint.sh

USER nylas

ENTRYPOINT ["/opt/nylas-setup/docker-entrypoint.sh"]

WORKDIR /opt/sync-engine/bin
