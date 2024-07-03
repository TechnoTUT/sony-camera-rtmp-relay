#!/bin/bash
sed -i 's|rtmp://10.33.0.1:1935/live/test|"$SERVER_URL"|g' /etc//nginx/nginx.conf
echo "$SERVER_URL"
nginx -g daemon off