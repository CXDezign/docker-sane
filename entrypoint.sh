#!/bin/bash -ex

# Environment Variables
set -e

# User Configuration
usermod -a -G scanner root

# GIT Clone
git clone https://github.com/SimulPiscator/AirSane.git

# Directories
mkdir AirSane-build && cd AirSane-build

# Make
cmake ../AirSane
make

# List Scanners
scanimage -L

# Execute
exec /usr/local/bin/airsaned
