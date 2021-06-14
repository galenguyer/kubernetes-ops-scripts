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
