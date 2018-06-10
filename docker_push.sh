#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u devopxy --password-stdin
docker build -t devopxy/xyce-deps:latest .
docker push devopxy/xyce-dep:latest
