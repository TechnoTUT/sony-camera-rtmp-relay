#!/bin/bash
echo "Stream Destination: $SERVER_URL"

if [ -z "${SERVER_URL}" ]; then
  echo "Error: SERVER_URL is not set"
  exit 1
fi

envsubst '${SERVER_URL}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

nginx -g 'daemon off;'