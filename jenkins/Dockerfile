FROM jenkins/jenkins:lts

USER root
RUN apt-get -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install python3 \
    python3-pip \
    python3-apt \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    pip3 install openshift && \
    apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io  && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/aptp-get/lists/*

ARG JENKINS_PORT

RUN /usr/local/bin/install-plugins.sh \
    jackson2-api \
    jdk-tool \
    display-url-api \
    command-launcher \
    authentication-tokens \
    github-branch-source \
    docker-slaves \
    bouncycastle-api \
    trilead-api \
    token-macro \
    workflow-step-api \
    structs \
    jsch \
    docker-plugin \
    workflow-scm-step \
    apache-httpcomponents-client-4-api \
    durable-task \
    github \
    script-security \
    scm-api \
    mailer \
    credentials-binding \
    docker-java-api \
    docker-commons \
    git \
    ssh-slaves \
    git-client \
    credentials \
    github-api \
    ssh-credentials \
    plain-credentials \
    cloudbees-folder \
    antisamy-markup-formatter \
    build-timeout \
    workflow-api \
    timestamper \
    workflow-support \
    workflow-durable-task-step \
    junit \
    matrix-project \
    resource-disposer \
    ws-cleanup \
    ant \
    ace-editor \
    jquery-detached \
    workflow-cps \
    workflow-job \
    workflow-basic-steps \
    gradle \
    pipeline-milestone-step \
    pipeline-input-step \
    pipeline-stage-step \
    pipeline-graph-analysis \
    pipeline-rest-api \
    handlebars \
    momentjs \
    pipeline-stage-view \
    pipeline-build-step \
    pipeline-model-api \
    pipeline-model-extensions \
    git-server \
    workflow-cps-global-lib \
    branch-api \
    workflow-multibranch \
    docker-workflow \
    pipeline-stage-tags-metadata \
    pipeline-model-declarative-agent \
    pipeline-model-definition \
    lockable-resources \
    workflow-aggregator \
    pipeline-github-lib \
    snakeyaml-api \
    configuration-as-code \
    dashboard-view \
    config-file-provider \
    matrix-auth \
    role-strategy \
    pam-auth \
    email-ext \
    publish-over \
    publish-over-ssh \
    ssh \
    locale
#ENV JENKINS_OPTS --httpPort=-1 --httpsPort=${JENKINS_PORT} --httpsCertificate=/var/lib/jenkins/cert --httpsPrivateKey=/var/lib/jenkins/pk

ARG DOCKER_GID

RUN addgroup --system --gid ${DOCKER_GID} real-docker && \
    addgroup jenkins real-docker

RUN python3 -m pip install --upgrade pip cffi && \
    pip install ansible && \
    pip3 install docker-py && \
    pip install mitogen ansible-lint && \
    pip install --upgrade pywinrm

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install -y kubectl

USER jenkins