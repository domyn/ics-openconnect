#!/bin/bash
set -eux

# Basic git configs
git config --global user.email 'docker-builder@example.com'
git config --global user.name 'Docker Builder'

# Init source
cd /mnt/ics-openconnect
git submodule init
git submodule update
make -C external

# Patch app

# Compile app
cd /mnt/ics-openconnect
./gradlew assembleDebug
