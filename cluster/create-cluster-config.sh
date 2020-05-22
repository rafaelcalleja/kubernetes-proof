#!/bin/bash

cp kind-config.yaml.template kind-config.yaml
DOCKER_BRIDGE_IP=$(docker inspect --format='{{range .IPAM.Config}}{{.Gateway}}{{end}}' bridge)
sed -i "s/apiServerAddress.*/apiServerAddress: \"${DOCKER_BRIDGE_IP}\"/g" kind-config.yaml