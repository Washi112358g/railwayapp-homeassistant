FROM ghcr.io/home-assistant/home-assistant:stable

# Instalar servidor SSH (Alpine Linux)
RUN apk add --no-cache openssh

# Crear directorios SSH
RUN mkdir -p /run/sshd && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

# Copiar scripts
COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/railway-homeassistant-entrypoint
COPY --chmod=0755 setup-ssh.sh /usr/local/bin/setup-ssh.sh

# Exponer puerto SSH
EXPOSE 22

# Iniciar SSH primero, luego Home Assistant en foreground
CMD ["/bin/sh", "-c", "/usr/local/bin/setup-ssh.sh & exec /usr/local/bin/railway-homeassistant-entrypoint"]
