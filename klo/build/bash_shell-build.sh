#!/bin/bash

set -eu

srcDir="$(readlink -f $(dirname $0)/../../)"

docker run --rm -it \
    --volume "${srcDir}:/mnt/ics-openconnect" \
    ics-openconnect-build bash
