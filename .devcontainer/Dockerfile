FROM almalinux:9

LABEL maintainer="TechnoTUT <gh@technotut.net>"

EXPOSE 1935

RUN dnf update -y \
    && dnf install -y dnsmasq nginx git \
    gcc gcc-c++ kernel-devel make \
    && dnf clean all