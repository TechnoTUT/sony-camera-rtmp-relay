#!/bin/bash
echo "Stream Destination: $SERVER_URL"

if [ -z "${SERVER_IP}" ]; then
  echo "Error: SERVER_IP is not set"
  exit 1
fi

envsubst '${SERVER_IP}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

nginx -g 'daemon off;'