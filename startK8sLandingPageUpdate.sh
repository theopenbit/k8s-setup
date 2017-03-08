#!/bin/bash
# usage startK8sLandingPageUpdate.sh <pathToYourKubeConfig>
if [ -z $1 ]; then
    echo 'usage startK8sLandingPageUpdate.sh <pathToYourKubeConfig>'
    exit 1
fi
sudo docker stop k8sLandingPageUpdate 
sudo docker rm k8sLandingPageUpdate
mkdir -p $(pwd)/temp
sudo docker run  --name k8sLandingPageUpdate -d -e KUBECONFIG=$1 -v $(dirname $1):$(dirname $1)  --restart always --volume $(pwd)/temp:/tmp k8slanding 
