#!/bin/bash

set -exu

GITIT_VERSION=0.15.1.2

# test local
docker build \
  --build-arg GITIT_VERSION=${GITIT_VERSION} \
  -t "eins78/gitit:${GITIT_VERSION}" \
  .

## build and publish
#
# docker buildx create --use
# docker buildx build \
#   --platform linux/amd64,linux/arm64 \
#   --build-arg GITIT_VERSION=${GITIT_VERSION} \
#   -t "eins78/gitit:${GITIT_VERSION}" \
#   --push \
#   .

