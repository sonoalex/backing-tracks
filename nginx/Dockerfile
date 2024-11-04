FROM nginxinc/nginx-unprivileged:1-alpine

# Add labels for better container management
LABEL maintainer="your-email@example.com"
LABEL description="Nginx Reverse Proxy for Backing Track App"

# Create directory for pid file
USER root

# Install additional tools that might be needed
RUN apk add --no-cache \
    bash \
    curl \
    gettext

# Create required directories and set permissions
RUN mkdir -p /app/static \
    && mkdir -p /var/cache/nginx \
    && mkdir -p /var/run/nginx \
    && chmod 755 /app/static \
    && chown -R nginx:nginx /app \
    && chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /var/run/nginx \
    && touch /etc/nginx/conf.d/default.conf \
    && chown -R nginx:nginx /etc/nginx

# Copy configuration templates
COPY --chown=nginx:nginx default.conf.tpl /etc/nginx/default.conf.tpl
COPY --chown=nginx:nginx nginx.conf.tpl /etc/nginx/nginx.conf.tpl

# Set environment variables
ENV  LISTEN_PORT=80 \
    APP_PORT=8000 \
    APP_HOST=web \
    WORKER_PROCESSES=auto \
    WORKER_CONNECTIONS=1024 \
    KEEPALIVE_TIMEOUT=65 \
    CLIENT_MAX_BODY_SIZE=10M

# Copy and set permissions for entrypoint script
COPY --chown=nginx:nginx entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to nginx user
USER nginx

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:${LISTEN_PORT}/health || exit 1

ENTRYPOINT ["/entrypoint.sh"]