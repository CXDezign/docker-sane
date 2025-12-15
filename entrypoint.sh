#!/bin/bash -ex

# User Modification
usermod -a -G saned,scanner root

# GIT Clone
git clone https://github.com/SimulPiscator/AirSane.git .

# Directories
mkdir build
cd build

# Make
cmake ..
make

# List Scanners
scanimage -L

# Service
mv /opt/airsane/build/airsaned /usr/local/bin

# Execute UDEV Daemon
/lib/systemd/systemd-udevd --daemon

# Execute Avahi Daemon
mkdir -p /run/dbus
dbus-daemon --system --address=unix:path=/run/dbus/system_bus_socket &
sleep 1

/usr/sbin/avahi-daemon --daemonize &

# Execute Airsane Daemon
/usr/local/bin/airsaned "$@"
