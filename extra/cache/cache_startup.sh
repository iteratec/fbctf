#!/bin/bash

set -e

sudo service memcached restart

while true; do
    sleep 5

    sudo service memcached status
done
