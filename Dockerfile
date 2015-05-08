FROM gliderlabs/alpine:3.1

MAINTAINER Greg Poirier <greg@opsee.co>

ENV NGINX_VERSION nginx-1.8.0

# Setup build tools
RUN apk --update add openssl-dev pcre-dev zlib-dev build-base

# Build nginx
RUN mkdir -p /tmp/src
ADD ${NGINX_VERSION}.tar.gz /tmp/src/
RUN cd /tmp/src/${NGINX_VERSION} && \
    ./configure \
      --with-http_ssl_module \
      --with-http_gzip_static_module \
      --prefix=/etc/nginx \
      --http-log-path=/var/log/nginx/access.log \
      --error-log-path=/var/log/nginx/error.log \
      --sbin-path=/usr/local/sbin/nginx && \
    make && \
    make install

# Clean up
RUN apk del build-base && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/* && \
    rm -f /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/example_ssl.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -s /dev/stderr /var/log/nginx/error.log

WORKDIR /etc/nginx

EXPOSE 80 443

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

