#!/usr/bin/env bash
pushd `dirname $0` > /dev/null

SERVICE_NAME="gcloudcli"
IMAGE_TAG="latest"

TMP_NO_CACHE="$1"

if [ "$TMP_NO_CACHE" = "" ]; then
  TMP_NO_CACHE="false"
else
  TMP_NO_CACHE="true"
fi

echo
echo [docker build start]
docker build --no-cache=$TMP_NO_CACHE -t ${SERVICE_NAME}:${IMAGE_TAG} .

echo
echo [docker run start]
MOUNT_HOST_DIR="/$USERPROFILE"
MOUNT_DOCKER_DIR="/mnt/hosthome"
TMP_MOUNT="${MOUNT_HOST_DIR}:${MOUNT_DOCKER_DIR}"
echo run image=${SERVICE_NAME}:${IMAGE_TAG} mount=$TMP_MOUNT

echo
docker run --rm \
  -v $TMP_MOUNT \
  -it ${SERVICE_NAME}:${IMAGE_TAG}

popd >/dev/null
