FROM ghcr.io/home-assistant/home-assistant:stable

# Install SSH server (Alpine Linux)
RUN apk add --no-cache openssh

# Create SSH directory and configure
RUN mkdir -p /run/sshd && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

# Copy entrypoint script
COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/railway-homeassistant-entrypoint

# Copy SSH setup script
COPY --chmod=0755 setup-ssh.sh /usr/local/bin/setup-ssh.sh

# Expose SSH port
EXPOSE 22

# Run both SSH and Home Assistant
CMD ["/bin/sh", "-c", "/usr/local/bin/setup-ssh.sh & /usr/local/bin/railway-homeassistant-entrypoint"]
