#!/bin/bash

if ! which jq > /dev/null; then
  cat <<EOF
jq is required, install it

Ubuntu: sudo apt install jq -y

EOF
exit 1;
fi


if ! cat /etc/docker/daemon.json |jq '.features.buildkit' |grep true > /dev/null; then

cat <<EOF
  https://docs.docker.com/develop/develop-images/build_enhancements/
  To enable docker BuildKit by default, set daemon configuration in /etc/docker/daemon.json feature to true and restart the daemon:

  {
      "features": {
          "buildkit": true
      }
  }
EOF
exit 1;
fi
