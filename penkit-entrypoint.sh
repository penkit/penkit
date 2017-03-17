#!/bin/sh
set -e

# if running as root, fix docker.sock permissions
if [ "$(id -u)" = "0" ] && [ -f /var/run/docker.sock ] ; then
  addgroup -g $(stat -c "%g" /var/run/docker.sock) docker
  addgroup ruby docker
fi

exec alpine-entrypoint.sh penkit $@
