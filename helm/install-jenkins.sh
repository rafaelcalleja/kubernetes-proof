#!/bin/bash

source ../bash/require-command.bash

commands=("helm")
requireCommand "${commands[@]}"

## Google & GCE Controller
##Crear la IP estática para asignarsela al LoadBalancer de Jenkins
##gcloud compute addresses create jenkins-static-ip --region=europe-west4
##kubectl apply -f jenkins/ingress-gce-controller.yaml

helm repo add jenkins https://charts.jenkins.io
helm repo update

## Google
## kubectl -n default apply -f jenkins/ingress.yaml

## Nginx Controller
## helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
## helm repo add stable https://kubernetes-charts.storage.googleapis.com/
## helm repo update
## kubectl apply -f jenkins/ingress-nginx-controller.yaml

helm install cd-jenkins jenkins/jenkins -f jenkins/values.yaml --wait

### password
printf $(kubectl get secret --namespace default cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

### Host to connect // LoadBalancer Version
#export SERVICE_IP=$(kubectl get svc --namespace default cd-jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
#echo http://$SERVICE_IP:8080/login

export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=cd-jenkins" -o jsonpath="{.items[0].metadata.name}")
echo http://127.0.0.1:8080
kubectl --namespace default port-forward $POD_NAME 8080:8080

#helm uninstall cd-jenkins -n default
#kubectl delete deployment -n default cd-jenkins

### Secrets necesarias para los agentes que hacen deploys
#https://support.cloudbees.com/hc/en-us/articles/360031575171-How-to-add-global-configuration-to-Kubernetes-Agents
#docker login
#kubectl create secret generic my-docker-config --from-file=.dockerconfigjson=${HOME}/.docker/config.json --type=kubernetes.io/dockerconfigjson

## Force upgrade from loadBalancer to ClusterIP
##kubectl get service/cd-jenkins -oyaml|sed 's/LoadBalancer/ClusterIP/g'|kubectl replace --force  -f -
##helm upgrade cd-jenkins stable/jenkins -f jenkins/values.yaml