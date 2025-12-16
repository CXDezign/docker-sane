#!/bin/bash -ex
set -euo pipefail

if [[ ! -x /usr/local/bin/airsaned ]]; then
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

	# Service
	mv /opt/airsane/build/airsaned /usr/local/bin
fi

# Execute UDEV Daemon
/lib/systemd/systemd-udevd --daemon

# Execute DBUS Socket
rm -f /run/dbus/pid
mkdir -p /run/dbus
dbus-daemon --system --address=unix:path=/run/dbus/system_bus_socket &
sleep 5

# Execute Avahi Daemon
#/usr/sbin/avahi-daemon --daemonize &
rm -f /run/avahi-daemon//pid
/usr/sbin/avahi-daemon --no-drop-root &

# List Scanners
scanimage -L

# Execute Airsane Daemon
exec /usr/local/bin/airsaned "$@"
