FROM hypriot/rpi-ruby:2.2.2
MAINTAINER theOpenBit <tob at schoenesnetz.de>
RUN apk update && apk add curl 
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.5.2/bin/linux/arm/kubectl
RUN chmod +x kubectl && chmod +x kubectl
COPY svc2html.rb /
COPY k8sLandingPageUpdate.sh /
COPY index.html.erb /
RUN chmod +x k8sLandingPageUpdate.sh
ENV PATH=$PATH:/
CMD ["k8sLandingPageUpdate.sh"]
