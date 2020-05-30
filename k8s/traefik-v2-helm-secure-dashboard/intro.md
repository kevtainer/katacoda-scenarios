In this tutorial we will install Traefik v2 to a Kubernetes Cluster using Helm v3. 

To goal of this workshop is to expose the Traefik dashboard securely while being accessible from the external web.

The lesson will cover the following topics:

* Installing Helm v3
* Installing Traefik v2 using the new "official" Helm charts
* Exposing the dashboard using the new CRD IngressRoute provider leveraging Host and Path routing rules
* Securing the dashboard with BasicAuth using the Middleware CRDs and modifying the IngressRoute for the dashboard to utilize the BasicAuth CRD.