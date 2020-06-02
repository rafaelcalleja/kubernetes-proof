#!/bin/bash

source ../bash/require-command.bash

commands=("curl" "kubectl")
requireCommand "${commands[@]}"

if ! which helm > /dev/null; then
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

if ! helm version; then
    echo "Failed installing helm"
fi
