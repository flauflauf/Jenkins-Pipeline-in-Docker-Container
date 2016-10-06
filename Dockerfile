# Use like:
#  docker build -t myjenkins .
#  docker run -p 8080:8080 -v <path_to_project>:/projectsource myjenkins
# Requires to have a Jenkinsfile in the project directory

FROM jenkins

# Install necessary plugins
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
RUN /usr/local/bin/install-plugins.sh git
RUN /usr/local/bin/install-plugins.sh workflow-aggregator

# install compile time dependencies
USER root
RUN sed -i 's/main/main contrib/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y git maven
USER jenkins

# create job
COPY jenkins-dev-config.xml /usr/share/jenkins/ref/init.groovy.d/
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/

# Jenkins builds the *local* repository. He looks for it at /projectsource
# That's why the volume parameter for docker run must point to the
# project root (see above).
VOLUME ["/projectsource"]