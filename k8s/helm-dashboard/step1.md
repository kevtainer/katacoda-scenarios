First, we must install the Helm binary so we can download the repository for Traefik in order to install it.

`curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash`{{execute}}

You may confirm the installation.

`helm version --short`{{execute}}

By default Helm will keep state locally in your environment in the _home_ directory.

`helm env`{{execute}}