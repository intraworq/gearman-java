FROM java:8-jre

MAINTAINER "Bolek Tekielski" bolek@vault13.pl

COPY gearman-server-0.8.11-20150731.182506-1.jar /opt/gearman/bin/gearman-server-0.8.11-20150731.182506-1.jar
COPY config.yml /opt/gearman/etc/config.yml

EXPOSE 4730 8080

CMD ["java", "-jar", "/opt/gearman/bin/gearman-server-0.8.11-20150731.182506-1.jar", "/opt/gearman/etc/config.yml"]