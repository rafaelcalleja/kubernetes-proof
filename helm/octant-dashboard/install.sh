#/bin/bash

#https://github.com/aleveille/octant-dashboard-turnkey
helm repo add octant-dashboard https://aleveille.github.io/octant-dashboard-turnkey/repo
helm upgrade octant-dashboard octant-dashboard/octant --namespace octant  --install --values myValues.yaml
