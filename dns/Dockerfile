FROM coredns/coredns:latest

EXPOSE 53 53/udp
COPY Corefile /etc/coredns/Corefile

ENTRYPOINT ["/coredns"]
CMD ["-conf", "/etc/coredns/Corefile"]