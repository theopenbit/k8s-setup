# Info

This project includes some bootstrap scripts for setup a simple kubernetes cluster infrastructure.

The idea is to setup the cluster using kubeadm (https://kubernetes.io/docs/getting-started-guides/kubeadm) and put some additional tooling around the cluster. 

* on master
```kubeadm init --pod-network-cidr=10.244.0.0/16```
* remember the token printed out on execution of ```kubeadm init```
* deploy flannel
```curl -sSL "https://github.com/coreos/flannel/blob/master/Documentation/kube-flannel.yml?raw=true" | sed "s/amd64/arm/g" | kubectl create -f -```
* wait until all container are running
```kubectl --namespace kube-system get po```
* on worker
```kubeadm join <masterip> --token  <token>```


All addional tooling is setup using docker-compose. 

A startup script is placed in the architecture depending subdirectory x86 or arm (for rpi).

# Landing page whith service information

At the moment I do not need a Loadbalancer, but I need a landing page with all services with their nodeports on it. 

The landing page should be updated automatically and published by an nginx server running outside the kubernetes cluster.

# NFS-Server

In order to provide easy persistent volumes to pods a nfs server is setup outside the k8s cluster.

The nfs server is running inside a docker container. Be sure the needed kernel modules are loaded into the host kernel:

```modprobe nfs```
```modprobe nfsd```


The share can be mount by clients using the ip of the host where the nfs-server is running:

```sudo mount -t nfs4 <hostOfNfsServer>:/ <localMountPoint>``` 




Additionally this project will filled up with some experimental k8s deployments for the cluster


