#!/bin/bash

source ../bash/require-command.bash

commands=("docker" "kubectl" "grep" "awk" "curl")
requireCommand "${commands[@]}"

if ! kubectl get namespace ingress-nginx > /dev/null; then
    echo "Ingress required please run: make init-ingress"
fi

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

kubectl apply -f ./dashboard.yaml

kubectl create serviceaccount dashboard-admin-sa
kubectl create clusterrolebinding dashboard-admin-sa --clusterrole=cluster-admin --serviceaccount=default:dashboard-admin-sa

kubectl describe secret $(kubectl get secrets|grep admin|awk '{print $1}')

DASHBOARD_URL="https://localhost/dashboard/"
if ! curl -s -o /dev/null -w "%{http_code}" -k ${DASHBOARD_URL} |grep 200 > /dev/null; then
  echo "Failed using ingress to ${DASHBOARD_URL}"
fi

cat <<EOF

--------
URL ${DASHBOARD_URL}
--------

EOF
