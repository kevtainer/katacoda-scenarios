#!/bin/bash
# Pass the name of a service to check ie: sh check-endpoint.sh traefik
# Will run forever...
external_ip=""
echo "Checking for LoadBalancer IP - this may take several minutes..."
while [ -z $external_ip ]; do
  echo "Waiting for end point..."
  external_ip=$(kubectl get svc $1 --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$external_ip" ] && sleep 10
done
echo 'End point ready:' && echo $external_ip