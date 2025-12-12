#!/bin/bash -ex

# Add root user to SANE group
RUN usermod -a -G scanner root

# Start SANE Daemon
saned -d -l
