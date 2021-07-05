# kubernetes-ops-scripts
useful scripts for managing my kubernetes cluster. keyword my. pls dont run these yourself. or do, i'm not your mom

## scripts
- `get-kube-conf` copies ~root/.kube/config to ~/.kube/config so kubectl can run locally. it also replaces the interal ip of the node with the public ip
- `sync-certs.sh` pulls the specified certs from bastion to local to k8s-01

## useful stuff
### [cert-manager](https://cert-manager.io) 
cert-manager can be used to get certificates from letsencrypt and hashicorp vault
#### installation
`kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.3.1/cert-manager.yaml` (from https://cert-manager.io/docs/installation/kubernetes/)
#### create cloudflare token secret
`CF_API_TOKEN=<MY_TOKEN> ./cert-manager/create-cloudflare-token-secret.sh`

### [Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
a web ui for kubernetes
#### installation
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.3.1/aio/deploy/recommended.yaml`
#### connection
run `kubectl proxy` and go to [http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)
##### authorization
apply the service account with `kubectl apply -f dashboard-adminuser.yaml`. get the token with `kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"; echo`

### Longhorn
distributed storage
#### installation
`kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.1/deploy/longhorn.yaml`
#### web dashboard
run `kubectl proxy` and navigate to [http://localhost:8001/api/v1/namespaces/longhorn-system/services/http:longhorn-frontend:80/proxy/#/dashboard](http://localhost:8001/api/v1/namespaces/longhorn-system/services/http:longhorn-frontend:80/proxy/#/dashboard)

### Other Commands
#### Allow scheduling on masters
`kubectl taint nodes --all node-role.kubernetes.io/master-`
