default: all

all: init-cluster init-load-balancer init-dashboard init-ingress

install:
	 @cat Readme.md

init-cluster:
	 @./init-cluster.sh

init-load-balancer:
	 @./init-load-balancer.sh

init-dashboard:
	 @./init-dashboard.sh

init-ingress:
	 @./init-ingress.sh

delete:
	 @kind delete cluster

