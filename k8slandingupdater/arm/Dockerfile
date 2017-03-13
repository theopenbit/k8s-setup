FROM hypriot/rpi-ruby:2.2.2
MAINTAINER theOpenBit <tob at schoenesnetz.de>
RUN apt-get update && apt-get install curl -y
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.5.2/bin/linux/arm/kubectl
RUN chmod +x kubectl 
COPY content/svc2html.rb /
COPY content/k8sLandingPageUpdate.sh /
COPY content/index.html.erb /
RUN cat /index.html.erb
RUN chmod +x k8sLandingPageUpdate.sh
ENV PATH=$PATH:/
CMD ["k8sLandingPageUpdate.sh"]
