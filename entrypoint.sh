#!/bin/bash -ex

# Environment Variables
set -e

# Sockets
/usr/bin/systemctl enable saned.socket

# User Configuration
usermod -a -G scanner root

# Default Configuration
if [ ! -f /etc/default/saned ]; then
    echo "RUN=yes" >> /etc/default/saned
    echo "RUN_AS_USER=root" >> /etc/default/saned
fi
if [ -f /etc/sane.d/saned.conf ]; then
    echo "${ALLOW_IP}" >> /etc/sane.d/saned.conf
fi
if [ -f /etc/sane.d/dll.conf ]; then
    echo "net" >> /etc/sane.d/dll.conf
    echo "${SANE_BACKEND_DLL}" >> /etc/sane.d/dll.conf
fi
if [ -f /etc/sane.d/net.conf ]; then
    echo "${SERVER_IP}" >> /etc/sane.d/net.conf
fi
if [ ! -f /etc/services ]; then
    echo "sane-port 6566/tcp" >> /etc/services
fi

# Restore Configurations
if [ ! -f /etc/sane.d/saned.conf ]; then
    cp -rpn /etc/sane.d.bak/* /etc/sane.d/
fi

wait
# Execute
#exec /usr/sbin/saned -l -e -n
