### install helm

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-istio-with-kubernetes

```bash
cd /tmp
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
chmod u+x install-helm.sh
./install-helm.sh
```

### install tiller

```bash
kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller

helm init --service-account tiller

```

### install helm chart

```bash
helm install stable/kubernetes-dashboard --name dashboard-demo

```

### install istio

```bash
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.1.7/charts/

helm repo list

helm install --name istio-init --namespace istio-system istio.io/istio-init

kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l

helm install --name istio --namespace istio-system --set grafana.enabled=true istio.io/istio


```

### install istio chart

```bash
helm install --name istio --namespace istio-system --set grafana.enabled=true istio.io/istio
kubectl get svc -n istio-system
```