FROM debian:jessie

MAINTAINER Vilppu Vuorinen "vilppu.vuorinen@jubic.fi"

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list

ENV NGINX_FLAVOR light

RUN  apt-get update \
  && apt-get -t jessie-backports install -y "nginx-${NGINX_FLAVOR}" \
  && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

ADD root /
ADD nginx.conf /etc/nginx/
RUN useradd -u 104 -m -s /bin/bash nginx \
  && mkdir -p /run/nginx /var/cache/nginx \
  && /usr/libexec/fix-permissions /run/nginx \
  && /usr/libexec/fix-permissions /var/cache/nginx \
  && /usr/libexec/fix-permissions /etc/nginx
RUN rm /usr/libexec/fix-permissions
VOLUME ["/var/cache/nginx"]

CMD ["nginx", "-g", "daemon off;"]
