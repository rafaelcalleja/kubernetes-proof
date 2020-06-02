https://developer.ibm.com/tutorials/use-jenkins-and-istio-for-canary-deployment/

docker build -t rafaelcalleja/sampleapp:v1 .
docker push rafaelcalleja/sampleapp:v1
kubectl apply -f deployment/app.yaml

istioctl manifest apply --set profile=demo
PROD_WEIGHT=100 CANARY_WEIGHT=0 envsubst < deployment/istio.yaml | kubectl apply -f -
