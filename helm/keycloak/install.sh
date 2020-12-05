#!/bin/bash

#https://github.com/codecentric/helm-charts/tree/master/charts/keycloak
helm repo add codecentric https://codecentric.github.io/helm-charts
helm install keycloak codecentric/keycloak

#export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=keycloak,app.kubernetes.io/instance=keycloak" -o name)
#echo "Visit http://127.0.0.1:8080 to use your application"
#kubectl --namespace default port-forward "$POD_NAME" 8080

