#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u devopxy --password-stdin
docker push devopxy/xyce-dep:latest
