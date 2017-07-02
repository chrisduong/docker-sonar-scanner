
FROM openjdk:8

LABEL maintainer="Ryan Mitchell <mitch@ryansmitchell.com>"

RUN apt-get update
RUN apt-get install -y curl git tmux htop maven

# Set timezone to CST
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /root

ADD https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.5.1.zip /root/sonarscanner.zip
RUN unzip sonarscanner.zip
RUN rm sonarscanner.zip

ENV SONAR_RUNNER_HOME=/root/sonar-scanner-2.5.1
ENV PATH $PATH:/root/sonar-scanner-2.5.1/bin

COPY sonar-runner.properties ./sonar-scanner-2.5.1/conf/sonar-runner.properties

# Use bash if you want to run the environment from inside the shell, otherwise use the command that actually runs the underlying stuff
#CMD /bin/bash
CMD sonar-runner -Dsonar.projectBaseDir=./src
