#!/bin/sh
set -e

# Generate SSH host keys if they don't exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Start SSH server in background
/usr/sbin/sshd -D &

# Keep the process running
wait
