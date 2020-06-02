#!/bin/bash

source ../bash/require-command.bash

commands=("kubectl")
requireCommand "${commands[@]}"

kubectl -n istio-system delete virtualservice grafana-vs kiali-vs prometheus-vs tracing-vs