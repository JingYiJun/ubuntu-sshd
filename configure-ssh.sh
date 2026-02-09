#!/bin/bash
set -e

# AUTHORIZED_KEYS is required
if [ -z "$AUTHORIZED_KEYS" ]; then
    echo "Error: AUTHORIZED_KEYS environment variable is required." >&2
    exit 1
fi

# Set up authorized keys for root
echo "$AUTHORIZED_KEYS" > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo "Authorized keys configured for root."

# Apply additional SSHD configuration if provided
if [ -n "$SSHD_CONFIG_ADDITIONAL" ]; then
    echo "$SSHD_CONFIG_ADDITIONAL" >> /etc/ssh/sshd_config
    echo "Additional SSHD configuration applied."
fi

# Apply additional SSHD configuration from a file if provided
if [ -n "$SSHD_CONFIG_FILE" ] && [ -f "$SSHD_CONFIG_FILE" ]; then
    cat "$SSHD_CONFIG_FILE" >> /etc/ssh/sshd_config
    echo "Additional SSHD configuration from file applied."
fi

# Start the SSH server
echo "Starting SSH server..."
exec /usr/sbin/sshd -D
