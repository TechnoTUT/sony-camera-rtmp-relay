FROM debian:trixie as build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    nginx \
    git wget tar build-essential \
    libpcre2-dev zlib1g-dev libssl-dev \
    libxml2 libxslt1.1 libxslt1-dev gettext-base ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && NGINX_VERSION=$(nginx -v 2>&1 | sed -e 's/.*nginx\///' -e 's/ .*//') \
    && mkdir -p /tmp && cd /tmp \
    && wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar xzf nginx-${NGINX_VERSION}.tar.gz \
    && git clone --depth 1 https://github.com/TechnoTUT/nginx-rtmp-module.git \
    && cd /tmp/nginx-${NGINX_VERSION} \
    && ./configure --with-compat --add-dynamic-module=/tmp/nginx-rtmp-module \
    && make modules

FROM debian:trixie-slim

LABEL maintainer="TechnoTUT <gh@technotut.net>"

EXPOSE 80 1935

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends nginx gettext-base curl \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/lib/nginx/modules \
    && mkdir -p /var/www/ustream/users/self \
    && chown -R www-data:www-data /var/www/ustream \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY --from=build /tmp/nginx-*/objs/*.so /usr/lib/nginx/modules/
COPY --from=build /tmp/nginx-rtmp-module/stat.xsl /var/www/ustream/stat.xsl
COPY nginx/nginx.conf.template /etc/nginx/nginx.conf.template
COPY nginx/channels.json /var/www/ustream/users/self/channels.json
COPY nginx/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:80/users/self/channels.json || exit 1

CMD ["/entrypoint.sh"]
