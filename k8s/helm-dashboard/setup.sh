#!/bin/sh

launch.sh

mkdir -p /home/traefik; cd /home/traefik

DEBIAN_FRONTEND=noninteractive apt install -qq apache2-utils

{ clear && echo "Traefik School is in session.";} 2> /dev/null