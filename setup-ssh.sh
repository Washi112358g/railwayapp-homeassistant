#!/bin/sh
set -e

# Generar claves SSH del host si no existen
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Crear authorized_keys para root
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Agregar clave pública (ED25519)
cat > /root/.ssh/authorized_keys << 'PUBKEY'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcRlPteDbLM9j6uoBv8FTtqqzor9ajooisyQmPtpldc home-assistant-ssh
PUBKEY

chmod 600 /root/.ssh/authorized_keys

# Iniciar SSH en foreground (reemplaza el proceso actual)
exec /usr/sbin/sshd -D
