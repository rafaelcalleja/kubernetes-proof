#!/bin/bash

source ../bash/require-command.bash

commands=("helm")
requireCommand "${commands[@]}"

helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update
#kubectl create namespace cd
helm install cd-jenkins stable/jenkins -f jenkins/values.yaml --wait

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
