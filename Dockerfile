FROM intelliops/cronicle:0.8.28

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
