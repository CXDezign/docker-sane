#!/bin/bash -ex

# Environment variables
set -e

# Start SANE Daemon
saned -l -e

# Add root user to SANE group
usermod -a -G scanner root

# Default SANE Configuration
echo "RUN=yes" >> /etc/default/saned
echo "${ALLOW_IP}" >> /etc/sane.d/cupsd.conf
echo "net" >> /etc/sane.d/dll.conf
echo "${SANE_BACKEND_DLL}" >> /etc/sane.d/dll.conf
echo "${SERVER_IP}" >> /etc/sane.d/net.conf
