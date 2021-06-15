#!/usr/bin/env bash
# retrieve kube config files so we can use kubectl remotely

# exit if a command fails
set -o errexit
set -o pipefail
# exit if required variables aren't set
set -o nounset

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-key-secret
type: Opaque
stringData:
  api-key: $CF_API_TOKEN
EOF
