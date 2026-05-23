#!/bin/sh
set -e

# Generate SSH host keys if they don't exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Create authorized_keys for root
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Add public key (ED25519)
cat > /root/.ssh/authorized_keys << 'PUBKEY'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9IyI0HeQ6dED/rMTUTye7Dn7HH7kLUPVVmCTynXJeh home-assistant-ssh
PUBKEY

chmod 600 /root/.ssh/authorized_keys

# Start SSH server in background
/usr/sbin/sshd -D &

# Keep the process running
wait
