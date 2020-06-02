#!/bin/bash

source ../bash/require-command.bash

commands=("kubectl")
requireCommand "${commands[@]}"

kubectl -n istio-system delete gateway grafana-gateway kiali-gateway prometheus-gateway tracing-gateway