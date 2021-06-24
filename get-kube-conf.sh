#!/usr/bin/env bash
# retrieve kube config files so we can use kubectl remotely

# exit if a command fails
set -o errexit
set -o pipefail
# exit if required variables aren't set
set -o nounset

host=k8s-galenguyer-01.eastus2.cloudapp.azure.com
mkdir -p ~/.kube/
ssh -t chef@"$host" sudo cat /root/.kube/config | sed -r -e "s/10.0.0.[0-9]{1,3}/$(dig +short $host)/g" > ~/.kube/config
