# Base Nginx Docker Image

This repository is used to compile a signed and verified version of Nginx
from source with support for OpenSSL and other common modules.

## Configuration

It includes default configuration files. If you wish to override these,
then please add the following to your Dockerfile when building from this image.

```
FROM opsee/nginx

RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/example\_ssl.conf
```

You can then COPY your configuration and website content into place.

## Build

docker build -t nginx .
