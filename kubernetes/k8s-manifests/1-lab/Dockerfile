# Use nginx:alpine-slim as base Docker Image
FROM nginx:alpine-slim

# Custom Labels
LABEL maintainer="Arun Labs"  
LABEL version="1.0"
LABEL description="A simple Nginx Application"

# Build arguments for dynamic values
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

# OCI Labels with dynamic values
LABEL org.opencontainers.image.authors="DemoDocker Labs"
LABEL org.opencontainers.image.title="Nginx Alpine Slim Application"
LABEL org.opencontainers.image.description="A lightweight Nginx application built on Alpine."
LABEL org.opencontainers.image.version="${VERSION:-1.0}"
LABEL org.opencontainers.image.revision="${VCS_REF:-unknown}" 
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.url=" https://github.com/secopsarch/dockerlabs"
LABEL org.opencontainers.image.vendor="Docker Labs by Arun"
LABEL org.opencontainers.image.licenses="Apache-2.0"

# Install required packages
RUN apk add --no-cache bash

# Copy files
COPY index.html /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

# Create server status page
RUN echo '<!DOCTYPE html>\n\
<html>\n\
<head>\n\
    <title>Server Status</title>\n\
    <style>\n\
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f0f0f0; }\n\
        .status-box { background-color: white; padding: 20px; border-radius: 5px;\n\
                     box-shadow: 0 2px 5px rgba(0,0,0,0.1); margin-bottom: 20px; }\n\
        .label { font-weight: bold; color: #666; }\n\
        .value { color: #333; }\n\
        h2 { color: #2c3e50; }\n\
    </style>\n\
</head>\n\
<body>\n\
    <div class="status-box">\n\
        <h2>Server Status Information</h2>\n\
        <p><span class="label">Hostname:</span> <span class="value">'$(hostname)'</span></p>\n\
        <p><span class="label">IP Address:</span> <span class="value">'$(hostname -i)'</span></p>\n\
        <p><span class="label">Nginx Version:</span> <span class="value">'$(nginx -v 2>&1)'</span></p>\n\
    </div>\n\
</body>\n\
</html>' > /usr/share/nginx/html/server-status.html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
