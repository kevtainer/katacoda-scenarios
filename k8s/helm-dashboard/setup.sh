#!/bin/sh

apt update -qq && apt install -qq -y apache2-utils

mkdir -p /home/traefik; cd /home/traefik

launch.sh

{ clear && echo "Traefik School is in session.";} 2> /dev/null