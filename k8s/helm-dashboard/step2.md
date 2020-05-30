In this lesson, we will add the official Traefik repository, install Traefik, and confirm that the LoadBalancer is exposed to the world.

First, we must add the official Traefik repo and update the manifests:

`helm repo add traefik https://containous.github.io/traefik-helm-chart
helm repo update`{{execute}}

Next, we will install the Traefik Helm Chart:

`helm install traefik traefik/traefik`{{execute}}

Now, we must wait for an IP to be assigned to the LoadBalancer, once that exists we can confirm Traefik is running.

`chmod a+x check-endpoint.sh && \
./check-endpoint.sh traefik`{{execute}}

Once you have the IP, you can confirm traefik is running by accessing that IP with curl.

`curl http://<endpoint_ip>`

Note: You should see a `404 page not found` response since we have not configured any Ingress routes.