FROM intelliops/cronicle:0.8.28

USER root

# AWS CLI
ENV AWS_CLI_VERSION 1.16.140
RUN apk -v --update add \
  python \
  py-pip \
  groff \
  less \
  mailcap \
  && \
  pip install --upgrade awscli==${AWS_CLI_VERSION} && \
  apk -v --purge del py-pip && \
  rm /var/cache/apk/*

# Other tools
RUN apk -v --update add \
  coreutils \
  bind-tools \
  curl \
  inotify-tools \
  socat && \
  rm /var/cache/apk/*

# kubectl
ENV KUBECTL_VERSION v1.14.1
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod 0775 /usr/local/bin/kubectl

# Simple templating engine
RUN apk -v --update add \
  gomplate \
  jq \
  && rm /var/cache/apk/*

# rsync support
RUN apk -v --update add \
  rsync \
  && rm /var/cache/apk/*

# sudo support
RUN apk -v --update add \
  sudo \
  && rm /var/cache/apk/*

RUN adduser cronicle wheel
RUN sed -e 's;^# \(%wheel.*NOPASSWD.*\);\1;g' -i /etc/sudoers

USER cronicle