#!/bin/bash
source /opt/nss.sh
echo ${BASIC_PASSWORD}|htpasswd -i -c /tmp/auth ${BASIC_USER}
envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
exec "$@"
