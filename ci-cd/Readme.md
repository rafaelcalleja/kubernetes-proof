https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes
https://cloud.google.com/solutions/continuous-delivery-jenkins-kubernetes-engine?hl=es-419

kubectl create ns production

helm install -n cd stable/jenkins -f jenkins/values.yaml

### password
printf $(kubectl get secret --namespace default cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

### Host to connect
export SERVICE_IP=$(kubectl get svc --namespace default cd-jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo http://$SERVICE_IP:8080/login
