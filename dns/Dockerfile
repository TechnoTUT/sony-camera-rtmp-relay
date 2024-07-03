FROM debian:12

LABEL maintainer="TechnoTUT <gh@technotut.net>"

EXPOSE 53/udp
EXPOSE 53/tcp

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y dnsmasq dnsutils \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r dnsmasq && usermod -a -G dnsmasq dnsmasq

COPY dns/dnsmasq.conf /etc/dnsmasq.conf
COPY dns/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]