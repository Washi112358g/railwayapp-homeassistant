#!/bin/sh
set -e

# Generate SSH host keys if they don't exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Create authorized_keys for root
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Add public key
cat > /root/.ssh/authorized_keys << 'PUBKEY'
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCh1/HrHTISlpCEgg8f7cBLjv2sUg4hcNtkNtKF8WH/qz9k7ji066d/sjKh2tZhzgFgB1eSAg6z3MFa5vqpk8FZTPIeLzsWm3S9JmsYMn4mWPLx0dig14j1q6lsqmbFgrCCRm/CKgyKlV/XMmnLhFMPZz1IRNPMZCUPN7wGPGnobLvbBi1axp6VZPGltuH4GaokLWLNUReyvi8SUirIzwqorUmmhJqW4B7EpVruP4Zqr7bMTbCyJD5LvDRkOlkirggB00/Pipp9g9DzCeEOIyELgfUMpl+1TCNacovIuvGiRRf/jejZhhbKX173AA0Z+Lgr/nzn7TRTxiS/7kQenWKfpg3cTcH2w33cTwuqqaHcglGnjWL3Hj
