@echo off
pushd %~dp0

set SERVICE_NAME=gcloudcli
set IMAGE_TAG=latest

set TMP_NO_CACHE=%~1

if "%TMP_NO_CACHE%" == "" (
    set TMP_NO_CACHE="false"
) else (
    set TMP_NO_CACHE="true"
)

echo.
echo [docker build start]
docker build --no-cache=%TMP_NO_CACHE% -t %SERVICE_NAME%:%IMAGE_TAG% .

echo.
echo [docker run start]
set MOUNT_HOST_DIR=%USERPROFILE%
set MOUNT_DOCKER_DIR=/mnt/hosthome
set TMP_MOUNT=%MOUNT_HOST_DIR%:%MOUNT_DOCKER_DIR%
echo run image=%SERVICE_NAME%:%IMAGE_TAG% mount=%TMP_MOUNT%

echo.
docker run --rm^
 -v %TMP_MOUNT%^
 -it %SERVICE_NAME%:%IMAGE_TAG%

popd & exit /b
