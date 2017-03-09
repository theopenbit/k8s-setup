# Info

This project includes some bootstrap scripts for setup a simple kubernetes cluster infrastructure.

The idea is to setup the cluster using kubeadm (https://kubernetes.io/docs/getting-started-guides/kubeadm) and put some additional tooling around the cluster. 

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


