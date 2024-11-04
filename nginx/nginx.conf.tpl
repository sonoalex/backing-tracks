worker_processes ${WORKER_PROCESSES};
pid /tmp/nginx.pid;

events {
    worker_connections ${WORKER_CONNECTIONS};
    multi_accept on;
    use epoll;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # Logging
    access_log /dev/stdout combined buffer=512k flush=1s;
    error_log /dev/stderr warn;

    # Basic Settings
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout ${KEEPALIVE_TIMEOUT};
    types_hash_max_size 2048;
    server_tokens off;

    # Compression
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss text/javascript application/x-javascript audio/mpeg;
    gzip_disable "msie6";

    # Security Headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

    # Include server configs
    include /etc/nginx/conf.d/*.conf;
}
