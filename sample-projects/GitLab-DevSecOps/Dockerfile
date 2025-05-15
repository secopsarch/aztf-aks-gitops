# Use nginx as base image
FROM nginx:alpine

# Copy the static content to nginx's default serving directory
COPY src/ /usr/share/nginx/html/

# Add security headers to nginx configuration
RUN echo 'server {\n\
    listen 80;\n\
    server_name localhost;\n\
    location / {\n\
        root /usr/share/nginx/html;\n\
        index index.html;\n\
        add_header X-Frame-Options "DENY";\n\
        add_header X-Content-Type-Options "nosniff";\n\
        add_header X-XSS-Protection "1; mode=block";\n\
        add_header Content-Security-Policy "default-src \'self\'; script-src \'self\' \'unsafe-inline\'";\n\
    }\n\
}' > /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80
