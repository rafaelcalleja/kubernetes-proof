#!/bin/bash

#https://github.com/codecentric/helm-charts/tree/master/charts/keycloak
helm repo add codecentric https://codecentric.github.io/helm-charts
helm install keycloak codecentric/keycloak
