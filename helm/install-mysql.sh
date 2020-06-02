#!/bin/bash

source ../bash/require-command.bash

commands=("helm")
requireCommand "${commands[@]}"

helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update

kubectl create namespace homologation
helm install mysql-homologation -n homologation -f mysql/values.yaml stable/mysql --wait

MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql-homologation -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)


