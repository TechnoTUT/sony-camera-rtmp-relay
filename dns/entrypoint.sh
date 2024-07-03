#!/bin/bash
echo "$STREAM_IP api.ustream.tv api" > /etc/hosts-dnsmasq
echo "nameserver $UPSTREAM_DNS" > /etc/dnsmasq_resolv.conf
dnsmasq --no-daemon --log-queries --log-facility=-