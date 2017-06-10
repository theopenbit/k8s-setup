#!/bin/bash
if [ -z $1 ] || [ -z $2 ]; then
    echo 'usage deploy.sh <pathToYourKubeConfigFile> <namespace>'
    exit 1
fi

docker run -v $(pwd):/k8swork -v $(dirname $1):$(dirname $1) -e KUBECONFIG=$1 theopenbit/rpi-k8sdeployer -n $2  -d /k8swork

if [ -d ../../nfsmnt ]; then
  echo copy test content to nfs storage
  mkdir -p ../../nfsmnt/$2/nginx
  cp -R ./content/ ../../nfsmnt/$2/nginx/
fi
