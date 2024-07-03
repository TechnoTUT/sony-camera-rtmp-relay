FROM debian:12

LABEL maintainer="TechnoTUT <gh@technotut.net>"

EXPOSE 53/udp

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y dnsmasq \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r dnsmasq && useradd -r -g dnsmasq dnsmasq

COPY dns/dnsmasq.conf /etc/dnsmasq.conf
COPY dns/hosts-dnsmasq /etc/hosts-dnsmasq
COPY dns/hosts-resolv.conf /etc/hosts-resolv.conf

CMD ["dnsmasq", "--no-daemon", "--log-queries", "--log-facility=-"]