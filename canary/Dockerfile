FROM alpine:latest
MAINTAINER The Dockbit Team "team@dockbit.com"

# In case no version is passed
ARG version=1.0
COPY ./app /app
EXPOSE 8080
ENTRYPOINT ["/app"]