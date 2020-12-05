default: all
NODES := 3

all: init-cluster init-ingress init-load-balancer init-dashboard init-metrics
min: NODES=1
min: init-cluster init-ingress init-load-balancer init-dashboard init-metrics

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

init-metrics:
	@./init-metric-server.sh

delete:
	 @kind delete cluster

