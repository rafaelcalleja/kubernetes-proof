### install kind

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/sbin/
```
more info: https://kind.sigs.k8s.io/docs/user/quick-start/

### delete cluster
kind delete cluster

### configurando
kind create cluster --config kind-example-config.yaml

### get logs
kind export logs

### Add ingrss controller

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

kubectl describe pods -n ingress-nginx ingress-nginx-admission-patch-x94rs