It's not considered best practice exposing the Traefik Dashboard to the world in the open. In future tutorials we may forego this step, but it's important to understand how to leverage Middleware to secure applications which are exposed to the world.

The Traefik provider in Kubernetes provides a BasicAuth middleware which will accept a secret that includes a htpasswd file for user authentication. We will configure this secret, deploy the BasicAuth Middleware CRD, and update the dashboard IngressRoute so it will prompt for credentials when accessed.

Let's create a `admin` user, this command will generate a file called `users`. We will need to provide our own password for this step to work.

`htpasswd -c users admin`{{execute}}

We should now have a `users` file, which we can use to create the Kubernetes Secret.

`kubectl create secret generic dashboard-auth-secret --from-file=users`{{execute}}

Optionally, we can inspect the secret if we like.

`kubectl get secret dashboard-auth-secret -o yaml`{{execute}}

Now that we've added the secret, we will create the BasicAuth Middleware.

Next, open the file `basicauth.yaml`{{open}}

```
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: dashboard-auth
spec:
  basicAuth:
    secret: dashboard-auth-secret
```{{copy}}

We don't actually need to change anything here, but we do need to apply the manifest to the Kubernetes API.

`kubectl apply -f basicauth.yaml`{{execute}}

For the last step, we will update the dashboard IngressRoute to use this newly defined middleware. Once we've completed this step our dashboard will _really_ be secured.

In the example below, we've added `middlewares` to the route definition. Open `dashboard.yaml`{{file}} and update it.

```
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: dashboard
spec:
  entryPoints:
    - websecure
  routes:
    - match: "Host(`[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
      kind: Rule
      services:
        - name: api@internal
          kind: TraefikService
      middlewares:
        - name: dashboard-auth
  tls: {}
```{{copy}}

Apply the configuration and we're done!

`kubectl apply -f dashboard.yaml`

Visit the dashboard URL, and we will now be prompted for a username and password.

https://[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/dashboard/