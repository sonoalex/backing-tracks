# default.conf.tpl
upstream web {
    server ${APP_HOST}:${APP_PORT};
    keepalive 32;
}

server {
    listen ${LISTEN_PORT};
    server_name localhost;

    # Security
    server_tokens off;

    # Health check endpoint
    location /health {
        access_log off;
        return 200 "healthy\n";
    }

    # Static files
    location /static/ {
        alias /app/static/;
        expires 30d;
        add_header Cache-Control "public, no-transform";
        access_log off;

        # Security headers for static content
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header X-Content-Type-Options "nosniff" always;
    }

    # Proxy settings
    location / {
        proxy_pass http://${APP_HOST};
        proxy_http_version 1.1;

        # Headers
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Port $server_port;

        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;

        # WebSocket support
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        # Buffer settings
        proxy_buffering on;
        proxy_buffer_size 4k;
        proxy_buffers 8 4k;
        proxy_busy_buffers_size 8k;

        # Max body size
        client_max_body_size ${CLIENT_MAX_BODY_SIZE};

        # Error handling
        proxy_intercept_errors on;
        error_page 500 502 503 504 /50x.html;
    }

    # Error pages
    location = /50x.html {
        root /usr/share/nginx/html;
        internal;
    }
}