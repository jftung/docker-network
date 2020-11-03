FROM jenkins/jenkins

RUN /usr/local/bin/install-plugins.sh \
    blueocean \
    docker-workflow \
    ghprb \
    git \
    workflow-aggregator

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
