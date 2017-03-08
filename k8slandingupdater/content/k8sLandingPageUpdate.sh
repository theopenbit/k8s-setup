#!/bin/sh
if [ -z $KUBECONFIG ]; then 
    echo no kubeconfig set
    exit 1
fi
KUBERNETESMASTER=$(cat $KUBECONFIG | grep server | sed  -r "s/server.*:\/\/(.*):.*/\1/")
while true 
do
    kubectl get svc --all-namespaces -o yaml > /tmp/svc.yaml
    ruby ./svc2html.rb -i /tmp/svc.yaml -o /tmp/index.html -k $KUBERNETESMASTER 
    sleep 2
done

