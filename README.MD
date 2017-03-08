This project includes some bootstrap scripts for setup simple an kubernetes cluster infrastructure.

The idea is to setup the cluster using kubeadm (https://kubernetes.io/docs/getting-started-guides/kubeadm).

I have no need for an Loadbalancer, but I need a landing page with all services with their nodeports on it. 

The landing page should be updated automatically and published by an nginx server running outside the kubernetes cluster.



