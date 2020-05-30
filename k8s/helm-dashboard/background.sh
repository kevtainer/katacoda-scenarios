#!/bin/sh

DEBIAN_FRONTEND=noninteractive apt update -qq < /dev/null > /dev/null
DEBIAN_FRONTEND=noninteractive apt install -qq -y apache2-utils < /dev/null > /dev/null
launch.sh

echo "done" >> /root/katacoda-background-finished