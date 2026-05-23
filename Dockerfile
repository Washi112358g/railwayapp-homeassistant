FROM ghcr.io/home-assistant/home-assistant:stable

RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd && mkdir -p /root/.ssh && chmod 700 /root/.ssh

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/railway-homeassistant-entrypoint

COPY --chmod=0755 setup-ssh.sh /usr/local/bin/setup-ssh.sh

EXPOSE 22

CMD ["/bin/sh", "-c", "/usr/local/bin/setup-ssh.sh && /usr/local/bin/railway-homeassistant-entrypoint"]
