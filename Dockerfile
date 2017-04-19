FROM openjdk:8-jre

MAINTAINER Marcelo França marcelo.franca@citsmart.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y python-software-properties software-properties-common wget unzip net-tools vim supervisor sudo 
RUN apt-get clean autoclean && apt-get autoremove -y
RUN wget https://archive.apache.org/dist/activemq/5.14.3/apache-activemq-5.14.3-bin.tar.gz
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN tar xzvf apache-activemq-5.14.3-bin.tar.gz -C /opt/

RUN mkdir -p /var/log/supervisor
RUN rm -f apache-activemq-5.14.3-bin.tar.gz
ENV TERM xterm

EXPOSE 8161
EXPOSE 61616
EXPOSE 5672
EXPOSE 61613
EXPOSE 1883
EXPOSE 61614

CMD ["/usr/bin/sudo", "/usr/bin/supervisord"]
