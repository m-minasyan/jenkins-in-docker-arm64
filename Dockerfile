FROM jenkins/jenkins:latest-jdk11
ENV DOCKER_COMPOSE_VER="v2.10.2"
ENV ARGOCD_VER="v2.4.11"
ENV DOCKER_ARCH="arm64"
ENV DOCKER_COMPOSE_ARCH="armv6"
ENV ARGOCD_ARCH="arm64"
ENV JENKINS_PLUGINS="envinject envinject-api locale postbuild-task configurationslicing copyartifact dark-theme disk-usage jobConfigHistory mask-passwords parameterized-trigger simple-theme-plugin"
ENV JENKINS_USER="root"
ENV JENKINS_TIMEZONE="Asia/Yerevan"

USER ${JENKINS_USER}
# apt update, upgrade and install staff
RUN apt update 
RUN yes | apt upgrade
RUN apt install -y --no-install-recommends gnupg ca-certificates apt-transport-https software-properties-common vim sudo zip curl
# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=${DOCKER_ARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \n
RUN apt update && apt install docker-ce docker-ce-cli containerd.io docker-ce-rootless-extras -y
# Install docker-compose
RUN apt update
RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VER}/docker-compose-linux-${DOCKER_COMPOSE_ARCH}" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
# Install ArgoCD CLI
RUN curl -LO https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VER}/argocd-linux-${ARGOCD_ARCH}
RUN mv argocd-linux-${ARGOCD_ARCH} /usr/local/bin/argocd
RUN chmod 755 /usr/local/bin/argocd
# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins ${JENKINS_PLUGINS}
# Change Jenkins user and timezone
RUN ln -snf /usr/share/zoneinfo/${JENKINS_TIMEZONE} /etc/localtime && echo ${JENKINS_TIMEZONE} > /etc/timezone
