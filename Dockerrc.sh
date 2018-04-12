#!/usr/bin/env bash

gcloud auth activate-service-account --key-file "/mnt/hosthome/${GCLOUD_CONFIG_KEY_FILE_PATH}"
gcloud config set project ${GCLOUD_CONFIG_PROJECT}

/bin/bash --login -i
cd /mnt/hosthome
