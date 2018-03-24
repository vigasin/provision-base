#!/bin/bash -e

MODULE=provision-base
VERSION=1.0

docker build -t vigasin/$MODULE:$VERSION .
docker push vigasin/$MODULE:$VERSION
