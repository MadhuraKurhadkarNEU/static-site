# Use a minimal base image
FROM caddy:2.4.6-alpine

# Copy the Caddyfile and HTML page to the container
COPY Caddyfile /etc/caddy/Caddyfile
COPY index.html /usr/share/caddy

# Set the environment variable for Caddy's root
ENV CADDYPATH /etc/caddy

EXPOSE 8080

# Start Caddy
# CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
