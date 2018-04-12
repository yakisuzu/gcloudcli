#!/usr/bin/env bash
pushd `dirname $0` > /dev/null

SERVICE_NAME="gcloudcli"
IMAGE_TAG="latest"
IMAGE_NAME=${SERVICE_NAME}:${IMAGE_TAG}

TMP_KEY_FILE_PATH="$1"
TMP_PROJECT="$2"
TMP_NO_CACHE="$3"

if [ "$TMP_KEY_FILE_PATH" = "" ]; then
  echo Require KEY_FILE_PATH >&2
  popd > /dev/null & exit
fi
if [ "$TMP_PROJECT" = "" ]; then
  echo Require PROJECT >&2
  popd > /dev/null & exit
fi

if [ "$TMP_NO_CACHE" = "" ]; then
  TMP_NO_CACHE="false"
else
  TMP_NO_CACHE="true"
fi

echo
echo [docker build start]
docker build --no-cache=$TMP_NO_CACHE -t ${IMAGE_NAME} .

echo
echo [docker run start]
if [ "$HOME" != "" ]; then
  MOUNT_HOST_DIR="/$HOME"
else
  MOUNT_HOST_DIR="/$USERPROFILE"
fi
MOUNT_DOCKER_DIR="/mnt/hosthome"
TMP_MOUNT="${MOUNT_HOST_DIR}:${MOUNT_DOCKER_DIR}"
echo run image=${IMAGE_NAME} mount=$TMP_MOUNT

echo
docker run --rm \
  -e GCLOUD_CONFIG_KEY_FILE_PATH=${TMP_KEY_FILE_PATH} \
  -e GCLOUD_CONFIG_PROJECT=${TMP_PROJECT} \
  -v $TMP_MOUNT \
  -it ${IMAGE_NAME}

popd >/dev/null
