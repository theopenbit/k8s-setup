This project includes some bootstrap scripts for setup a simple kubernetes cluster infrastructure.

The idea is to setup the cluster using kubeadm (https://kubernetes.io/docs/getting-started-guides/kubeadm) and put some additional tooling around the cluster. 

At the moment I do not need a Loadbalancer, but I need a landing page with all services with their nodeports on it. 

The landing page should be updated automatically and published by an nginx server running outside the kubernetes cluster.

Additionally this project will filled up with some experimental k8s deployments for the cluster


