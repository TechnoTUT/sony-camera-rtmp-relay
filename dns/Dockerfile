FROM almalinux:9

LABEL maintainer="TechnoTUT <gh@technotut.net>"

EXPOSE 53
EXPOSE 53/udp

RUN dnf update -y \
    && dnf install -y dnsmasq \
    && dnf clean all

COPY dns/dnsmasq.conf /etc/dnsmasq.conf
COPY dns/hosts-dnsmasq /etc/hosts-dnsmasq
COPY dns/hosts-resolv.conf /etc/hosts-resolv.conf

CMD ["dnsmasq", "--no-daemon", "--log-queries", "--log-facility=-"]