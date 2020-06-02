cd ~

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.6.0 sh -

cd istio-1.6.0

echo export PATH=${PWD}/bin:${PATH} >> ~/.bashrc

### install
istioctl manifest apply --set profile=demo
kubectl label namespace default istio-injection=enabled

### deploy sample app
kubectl apply -f bookinfo.yaml

### test success
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"

expected: ```<title>Simple Bookstore App</title>```

### expose app
kubectl apply -f bookinfo-gateway.yaml
istioctl analyze


### Determining the ingress IP and ports
kubectl get svc istio-ingressgateway -n istio-system

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo http://$GATEWAY_URL/productpage

### dashboard
istioctl dashboard kiali


