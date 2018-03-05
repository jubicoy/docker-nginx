FROM nginx:stable
MAINTAINER Vilppu Vuorinen "vilppu.vuorinen@jubic.fi"

RUN  apt-get update \
  && apt-get install -y \
    libnss-wrapper \
    gettext \
    apache2-utils \
  && rm -rf /var/lib/apt/lists/*

ENV USER_NAME nginx

COPY root /

RUN  cat /opt/nss.sh >> /etc/bash.bashrc \
  && mkdir -p \
    /run/nginx \
    /var/lib/nginx \
    /var/cache/nginx \
  && /usr/libexec/fix-permissions /etc/nginx \
  && /usr/libexec/fix-permissions /run/nginx \
  && /usr/libexec/fix-permissions /var/cache/nginx \
  && /usr/libexec/fix-permissions /var/lib/nginx \
  && /usr/libexec/fix-permissions /var/log/nginx \
  && /usr/libexec/fix-permissions /var/www

WORKDIR /var/www
EXPOSE 5000
VOLUME ["/var/cache/nginx"]

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
