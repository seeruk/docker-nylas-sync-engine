#!/usr/bin/env bash

envsubst < /opt/nylas-setup/config.json.tpl > /etc/inboxapp/config.json
envsubst < /opt/nylas-setup/secrets.yml.tpl > /etc/inboxapp/secrets.yml

exec $@
