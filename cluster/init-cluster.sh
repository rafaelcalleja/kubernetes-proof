#!/bin/bash

source ../bash/require-command.bash

commands=("docker" "docker-compose" "bash" "grep" "kubectl" "kind" "curl" "openssl")
requireCommand "${commands[@]}"

cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  # WARNING: It is _strongly_ recommended that you keep this the default
  # (127.0.0.1) for security reasons. However it is possible to change this.
  apiServerAddress: "$(docker inspect --format='{{range .IPAM.Config}}{{.Gateway}}{{end}}' bridge)"
  # By default the API server listens on a random open port.
  # You may choose a specific port but probably don't need to in most cases.
  # Using a random port makes it easier to spin up multiple clusters.
  apiServerPort: 6443
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
- role: worker
- role: worker
EOF

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml

kubectl describe pod foo-app

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

kubectl get svc echo