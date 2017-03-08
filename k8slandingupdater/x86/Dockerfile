FROM ruby:2.1-alpine
MAINTAINER theOpenBit <tob at schoenesnetz.de>
RUN apk update && apk add curl 
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.5.2/bin/linux/amd64/kubectl
RUN chmod +x kubectl && chmod +x kubectl
COPY content/svc2html.rb /
COPY content/k8sLandingPageUpdate.sh /
COPY content/index.html.erb /
RUN chmod +x k8sLandingPageUpdate.sh
ENV PATH=$PATH:/
CMD ["k8sLandingPageUpdate.sh"]
