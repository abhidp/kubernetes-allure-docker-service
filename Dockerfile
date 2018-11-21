FROM openjdk:8-jdk-slim

ARG RELEASE=2.7.0
ARG ALLURE_GITHUB=https://github.com/allure-framework/allure2/releases/download

RUN apt-get update
RUN apt-get install curl -y
RUN apt-get install vim -y
RUN apt install python-pip -y
RUN pip install Flask
RUN apt-get install --reinstall procps -y
RUN apt-get install wget

RUN rm /etc/java-8-openjdk/accessibility.properties
RUN touch /etc/java-8-openjdk/accessibility.properties

RUN wget --no-verbose -O /tmp/allure-$RELEASE.zip $ALLURE_GITHUB/$RELEASE/allure-$RELEASE.zip \
  && unzip /tmp/allure-$RELEASE.zip -d / \
  && rm -rf /tmp/*

RUN apt-get remove --auto-remove wget -y

RUN chmod -R +x /allure-$RELEASE/bin

COPY allure-docker-api /app/allure-docker-api

ENV ALLURE_HOME=/allure-$RELEASE
ENV PATH=$PATH:$ALLURE_HOME/bin
ENV RESULTS_DIRECTORY=/app/allure-results
ENV REPORT_DIRECTORY=/app/allure-report
RUN allure --version

WORKDIR /app
ADD scripts/runAllure.sh /app
ADD scripts/generateAllureReport.sh /app
ADD scripts/checkAllureResultsFiles.sh /app
ADD scripts/runAllureAPI.sh /app
RUN mkdir $RESULTS_DIRECTORY
RUN mkdir $REPORT_DIRECTORY
RUN mkdir $REPORT_DIRECTORY/history

# VOLUME [ "$RESULTS_DIRECTORY" ]

ENV PORT=4040
EXPOSE $PORT
EXPOSE 5050

CMD /app/runAllure.sh & /app/runAllureAPI.sh & /app/checkAllureResultsFiles.sh