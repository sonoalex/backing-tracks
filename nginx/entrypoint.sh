#!/usr/bin/env bash
set -e

# Replace environment variables in configuration files
envsubst '${WORKER_PROCESSES},${WORKER_CONNECTIONS},${KEEPALIVE_TIMEOUT}' < /etc/nginx/nginx.conf.tpl > /etc/nginx/nginx.conf
envsubst '${APP_PORT},${APP_HOST},${LISTEN_PORT},${CLIENT_MAX_BODY_SIZE}' < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf

# Verify nginx configuration
nginx -t

# Start nginx
exec nginx -g 'daemon off;'