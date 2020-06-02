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

### Host to connect
export SERVICE_IP=$(kubectl get svc --namespace default cd-jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo http://$SERVICE_IP:8080/login

#helm uninstall cd-jenkins -n default
#kubectl delete deployment -n default cd-jenkins

### Secrets necesarias para los agentes que hacen deploys
#https://support.cloudbees.com/hc/en-us/articles/360031575171-How-to-add-global-configuration-to-Kubernetes-Agents
#docker login
#kubectl create secret generic my-docker-config --from-file=.dockerconfigjson=${HOME}/.docker/config.json --type=kubernetes.io/dockerconfigjson
