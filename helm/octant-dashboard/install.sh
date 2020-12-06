#/bin/bash

#https://github.com/aleveille/octant-dashboard-turnkey
helm repo add octant-dashboard https://aleveille.github.io/octant-dashboard-turnkey/repo
helm upgrade octant-dashboard octant-dashboard/octant --namespace octant  --install --values myValues.yaml

#https://stackoverflow.com/questions/53550321/keycloak-gatekeeper-aud-claim-and-client-id-do-not-match
#https://github.com/louketo/louketo-proxy/issues/529

