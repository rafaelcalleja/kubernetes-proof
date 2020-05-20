default: image

all: image

image:
	export BUILD=$${BUILD:-$(shell git rev-parse --abbrev-ref HEAD | sed -e 's=/=_=g')}; \
	docker build -f Dockerfile \
	--cache-from dokify/homologation-jenkins:$${BUILD} \
	-t dokify/homologation-jenkins:lastest \
	-t odkify/homologation-jenkins:$${BUILD} \
	--compress .
