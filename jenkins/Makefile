default: all

all: image

image:
	 env DOCKER_GID=$$(stat -c '%g' $${DOCKER_SOCKET:-/var/run/docker.sock}) docker-compose build
