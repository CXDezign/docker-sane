#!/bin/bash -ex

# Add root user to SANE group
usermod -a -G scanner root

# Start SANE Daemon
saned -l -e
