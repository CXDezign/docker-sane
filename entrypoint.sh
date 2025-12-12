#!/bin/bash -ex

# Start saned
saned -d -l

# Restore default SANE config if empty
if [ ! -f /etc/sane.d/saned.conf ]; then
    cp -rpn /etc/sane.d.bak/* /etc/sane.d/
fi
