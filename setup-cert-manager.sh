#!/usr/bin/env bash
set -euo pipefail

# install cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml
# apply my personal cert
kubectl apply -f cert-manager/ca-key-pair.yaml
# install a cluster issuer with my personal cert
kubectl apply -f cert-manager/ca-cluster-issuer.yaml
