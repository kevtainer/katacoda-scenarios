In order to expose the Dashboard to the world, we must configure a IngressRoute, which is a custom resource definition provider installed by Traefik.

Copy the following yaml into the `dashboard.yaml`{{open}} file:

```
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: dashboard
spec:
  entryPoints:
    - websecure
  routes:
    - match: "Host(`[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com`) && ((`PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
      kind: Rule
      services:
        - name: api@internal
          kind: TraefikService
  tls: {}
```

Note: The Katacoda environment terminates SSL for us, so it is not necessary to setup a TLS provider with this configuration. However, we are still using the `websecure` http entrypoint because the internal API/dashboard service requires `https`.

We may now deploy the newly defined IngressRoute and expose the dashboard:

`kubectl apply -f dashboard.yaml`

Once deployed, you may now access your dashboard through the DNS provided by Katacoda:

<pre>https://[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/dashboard/</pre>