FROM alpine:3.6

MAINTAINER "Bolesław Tekielski" bolek@zeepeetek.pl

RUN apk --update add openjdk8-jre
RUN apk --no-cache add supervisor
RUN apk update && apk add ca-certificates && update-ca-certificates && apk add openssl 

RUN mkdir -p /opt/gearman/etc \
	&& mkdir -p /opt/gearman/bin

RUN LINK=$(wget -qO- https://raw.githubusercontent.com/tboloo/gearman-java/master/current.version.link) \
  	&& wget -q -O gearman-server.jar ${LINK} \
  	&& mv gearman-server.jar /opt/gearman/bin/

COPY config.yml /opt/gearman/etc/config.yml
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/log/supervisor 

EXPOSE 4730 8080

VOLUME ["/var/log/supervisor"]
VOLUME ["/opt/gearman/etc"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]