#!/bin/bash

docker run --rm -it \
    --volume ../../:/mnt/ics-openconnect \
    ics-openconnect-build
