#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

IMAGE=node-dev
NODE_VERSION=14
docker build --build-arg=NODE_VERSION=$NODE_VERSION --tag $IMAGE:$NODE_VERSION ..

docker run --user="$(id -u):$(id -g)" --name test-node-dev --rm -v "$PWD:/app:ro" $IMAGE:$NODE_VERSION
