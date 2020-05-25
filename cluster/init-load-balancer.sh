#!/bin/bash

source ../bash/require-command.bash

commands=("docker" "bash" "grep" "kubectl" "kind" "head" "openssl")
requireCommand "${commands[@]}"

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

IP_PREFIX=$(docker inspect --format='{{range .IPAM.Config}}{{.Gateway}}{{end}}' kind|grep -oP '(?:\d{1,3}\.){1}\d{1,3}'|head -n1)

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $IP_PREFIX.255.1-$IP_PREFIX.255.250
EOF

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: echo
spec:
  replicas: 3
  selector:
    matchLabels:
      app: echo
  template:
    metadata:
      labels:
        app: echo
    spec:
      containers:
      - name: echo
        image: inanimate/echo-server
        ports:
        - containerPort: 8080
EOF

kubectl expose replicaset echo --type=LoadBalancer
