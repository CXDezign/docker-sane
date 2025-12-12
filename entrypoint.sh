#!/bin/bash -ex

# Environment Variables
set -e

# Execute
exec /usr/sbin/saned -D -e -n

# User Configuration
usermod -a -G scanner root

# Default Configuration
echo "RUN=yes" >> /etc/default/saned
echo "${ALLOW_IP}" >> /etc/sane.d/saned.conf
echo "net" >> /etc/sane.d/dll.conf
echo "${SANE_BACKEND_DLL}" >> /etc/sane.d/dll.conf
echo "${SERVER_IP}" >> /etc/sane.d/net.conf
echo "sane-port       6566/tcp" >> /etc/services

# Restore Configurations
if [ ! -f /etc/sane.d/saned.conf ]; then
    cp -rpn /etc/sane.d.bak/* /etc/sane.d/
fi
