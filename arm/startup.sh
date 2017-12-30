#!/bin/bash
if [ -z $1 ]; then
    echo 'usage startup.sh <pathToYourKubeConfigFile>'
    exit 1
fi
hash curl &> /dev/null
if [ $? -eq 1 ]; then
    echo >&2 "curl not found. please install it..."
    exit 1 
fi

hash docker-compose &> /dev/null
if [ $? -eq 1 ]; then
    echo >&2 "docker-compose not found. installing it..."
    curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi
hash nfsstat &> /dev/null
if [ $? -eq 1 ]; then
sudo apt update
sudo apt install -y nfs-common
fi
mkdir -p nfsmnt
chmod 777 nfsmnt
mkdir -p temp
chmod 777 temp
export KUBECONFIG=$1
export KUBECONFIG_PATH=$(dirname $KUBECONFIG)
#export KUBEFQDN=192.168.1.37
#export KUBEFQDN=172.17.100.248
#export KUBEFQDN=192.168.2.1
export KUBEFQDN=192.168.0.1
sudo -E docker-compose up -d
echo 'deploying heapster to k8s-cluster'
kubectl apply -f ./k8s/heapster.yaml
echo 'deploying kube-ops-view to k8s-cluster'
cd ./k8s/kube-ops-view
./deploy.sh $1 monitoring
echo 'deploying dashboard to k8s-cluster'
#curl -sSL https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml | sed "s/amd64/arm/g" | kubectl apply -f -
#curl -sSL https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard-arm-head.yaml | kubectl apply -f -
kubectl apply -f ./k8s/kubernetes-dashboard-arm.yaml
