#!/bin/bash

MLC_VERSION=${MLC_VERSION:-2.8.0}
if [[ ${MLC_HOST_PLATFORM_FLAVOR} != 'x86_64' ]]; then
  echo "Platform ${MLC_HOST_PLATFORM_FLAVOR} is not supported yet!";
  exit 1
fi
mkdir install
FILENAME=libtensorflow-cpu-${MLC_HOST_OS_TYPE}-x86_64-${MLC_VERSION}.tar.gz
wget -q --no-check-certificate https://storage.googleapis.com/tensorflow/libtensorflow/${FILENAME}
tar -C install -xzf ${FILENAME}

test $? -eq 0 || exit 1
