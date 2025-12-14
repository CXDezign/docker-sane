#!/bin/bash -ex

# User Configuration
usermod -a -G scanner root

# GIT Clone
git clone https://github.com/SimulPiscator/AirSane.git

# Directories
mkdir AirSane-build && cd AirSane-build

# Make
cmake ../AirSane
make

# Directories
mv ./AirSane/etc/* /etc/airsane/
mv ./AirSane/build/airsaned /usr/local/bin

# List Scanners
scanimage -L

# Execute
exec /usr/local/bin/airsaned
