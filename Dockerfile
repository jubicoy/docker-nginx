FROM debian:jessie

MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.7-1~jessie

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

ADD root /
RUN mkdir -p /run/nginx \
  && /usr/libexec/fix-permissions /run/nginx \
  &&/usr/libexec/fix-permissions /var/cache/nginx \
  && /usr/libexec/fix-permissions /etc/nginx
RUN rm /usr/libexec/fix-permissions
VOLUME ["/var/cache/nginx"]

CMD ["nginx", "-g", "pid /run/nginx/nginx.pid; daemon off;"]
