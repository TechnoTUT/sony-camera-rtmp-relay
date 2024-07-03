FROM almalinux:9

LABEL maintainer="TechnoTUT <gh@technotut.net>"

EXPOSE 53
EXPOSE 53/udp

RUN dnf update -y \
    && dnf install -y dnsmasq \
    && dnf clean all