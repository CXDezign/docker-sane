#!/bin/bash -ex

# Environment Variables
set -e

# Execute
exec /usr/sbin/saned -l -e

# User Configuration
usermod -a -G scanner root

# Default Configuration
echo "RUN=yes" >> /etc/default/saned
echo "${ALLOW_IP}" >> /etc/sane.d/cupsd.conf
echo "net" >> /etc/sane.d/dll.conf
echo "${SANE_BACKEND_DLL}" >> /etc/sane.d/dll.conf
echo "${SERVER_IP}" >> /etc/sane.d/net.conf

# Restore Configurations
if [ ! -f /etc/sane.d/saned.conf ]; then
    cp -rpn /etc/sane.d.bak/* /etc/sane.d/
fi
