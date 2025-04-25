#!/bin/bash

# Enable debugging
set -x

# Set default port if not provided
export PORT=${PORT:-8080}

# Print environment variables for debugging
echo "Environment variables:"
env

# Create a simple Nginx configuration
echo "Creating Nginx configuration..."
cat > /etc/nginx/conf.d/default.conf << EOF
server {
    listen ${PORT};
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;
    location / {
        try_files \$uri \$uri/ /index.html;
    }
}
EOF

# Verify the configuration
echo "Nginx configuration:"
cat /etc/nginx/conf.d/default.conf

# Start Nginx
echo "Starting Nginx on port $PORT"
exec nginx -g "daemon off;" 