FROM nginx:stable
MAINTAINER Vilppu Vuorinen "vilppu.vuorinen@jubic.fi"

RUN  apt-get update \
  && apt-get install -y \
    libnss-wrapper \
    gettext \
  && rm -rf /var/lib/apt/lists/*

ENV USER_NAME nginx

ADD root /
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/default.conf /etc/nginx/conf.d/

RUN  cat /opt/nss.sh >> /etc/bash.bashrc \
  && mkdir -p \
    /run/nginx \
    /var/lib/nginx \
    /var/cache/nginx \
    /var/www/html \
  && /usr/libexec/fix-permissions /run/nginx \
  && /usr/libexec/fix-permissions /var/cache/nginx \
  && /usr/libexec/fix-permissions /var/lib/nginx \
  && /usr/libexec/fix-permissions /etc/nginx \
  && /usr/libexec/fix-permissions /var/log/nginx

ADD conf/index.html /var/www/html/

WORKDIR /var/www
EXPOSE 5000
VOLUME ["/var/cache/nginx"]

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
