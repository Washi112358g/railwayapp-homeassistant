#!/usr/bin/env sh
set -eu

CONFIG_DIR="${CONFIG_DIR:-/config}"
CONFIG_FILE="${CONFIG_DIR}/configuration.yaml"

mkdir -p "${CONFIG_DIR}"
touch "${CONFIG_FILE}"

# Railway traffic is forwarded through an internal reverse proxy.
# Trust that proxy range so Home Assistant accepts forwarded headers.
if ! grep -q "RAILWAY_PROXY_CONFIG_START" "${CONFIG_FILE}"; then
  cat >> "${CONFIG_FILE}" <<'EOF'

# RAILWAY_PROXY_CONFIG_START
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 127.0.0.1
    - 100.64.0.0/10
# RAILWAY_PROXY_CONFIG_END
EOF
fi

# Home Assistant binds to 8123 internally; expose Railway's dynamic PORT.
socat TCP-LISTEN:"${PORT}",fork,reuseaddr TCP:127.0.0.1:8123 &

exec /init
