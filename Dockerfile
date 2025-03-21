FROM alpine:latest

ENV DAEMON_VERSION="1.0.0"

RUN apk update && apk add build-base
COPY daemon /usr/local/bin/daemon
COPY config.yml /etc/daemon/config.yml