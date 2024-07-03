FROM debian:12

LABEL maintainer="TechnoTUT <gh@technotut.net>"

EXPOSE 1935
EXPOSE 80

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx \
    git wget tar build-essential libperl-dev libgeoip-dev libgd-dev libpcre3 libpcre3-dev libxml2 libxslt1-dev libxslt1.1 libxslt1-dev \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /tmp && cd /tmp && wget https://nginx.org/download/nginx-1.22.1.tar.gz && tar xzf nginx-1.22.1.tar.gz && rm -f nginx-1.22.1.tar.gz \
    && wget https://www.openssl.org/source/openssl-3.3.1.tar.gz && tar xzf openssl-3.3.1.tar.gz && rm -f openssl-3.3.1.tar.gz \
    && git clone https://github.com/TechnoTUT/nginx-rtmp-module.git \
    && cd /tmp/nginx-1.22.1 \
    && ./configure --with-cc-opt='-g -O2 -ffile-prefix-map=/build/nginx-AoTv4W/nginx-1.22.1=. -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2' \
     --with-ld-opt='-Wl,-z,relro -Wl,-z,now -fPIC' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=stderr \
     --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
     --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-compat --with-debug --with-pcre-jit --with-http_ssl_module \
     --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads \
     --with-http_addition_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_secure_link_module \
     --with-http_sub_module --with-mail_ssl_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-stream_realip_module --with-http_geoip_module=dynamic --with-http_image_filter_module=dynamic \
     --with-http_perl_module=dynamic --with-http_xslt_module=dynamic --with-mail=dynamic --with-stream=dynamic --with-stream_geoip_module=dynamic \
     --add-dynamic-module=/tmp/nginx-rtmp-module --with-openssl=/tmp/openssl-3.3.1 \
    && make modules \
    && mkdir -p /usr/lib/nginx/modules && cp /tmp/nginx-1.22.1/objs/*.so /usr/lib/nginx/modules \
    && rm -rf /tmp/nginx-1.22.1 /tmp/openssl-3.3.1 /tmp/nginx-rtmp-module \
    && mkdir -p /var/www/ustream/users/self && chown -R www-data:www-data /var/www/ustream \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/channels.json /var/www/ustream/users/self/channels.json

CMD ["nginx", "-g", "daemon off;"]
