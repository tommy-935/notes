FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Nginx
RUN apt-get update && apt-get install -y nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy custom Nginx config
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY vhost /etc/nginx/conf.d/vhost

# Expose port 80
EXPOSE 80 443 8081 8082

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
