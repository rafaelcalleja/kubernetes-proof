#!/bin/bash

source ../bash/require-command.bash

commands=("bash" "grep" "kubectl" "kind" "curl")
requireCommand "${commands[@]}"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml

kubectl wait --namespace default \
  --for=condition=ready pod/bar-app \
  --timeout=90s

kubectl wait --namespace default \
  --for=condition=ready pod \
  --selector=app=bar \
  --timeout=90s

sleep 5

if ! curl -s localhost/foo|grep foo > /dev/null; then
    echo "Installing ingress controller failed"
    exit 1
fi

if ! curl -s localhost/bar|grep bar > /dev/null; then
    echo "Installing ingress controller failed"
    exit 1
fi
