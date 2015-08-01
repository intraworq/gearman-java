FROM java:8-jre

MAINTAINER "Bolesław Tekielski" bolek@vault13.pl

RUN apt-get update \
  	&& apt-get install -y --no-install-recommends supervisor
RUN mkdir -p /opt/gearman/etc \
	&& mkdir -p /opt/gearman/bin

RUN LINK=$(wget -qO- https://raw.githubusercontent.com/intraworq/gearman-java/master/current.version.link) \
  	&& wget -q -O gearman-server.jar ${LINK} \
  	&& mv gearman-server.jar /opt/gearman/bin/

COPY config.yml /opt/gearman/etc/config.yml
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/log/supervisor \
  && chgrp staff /var/log/supervisor \
  && chmod g+w /var/log/supervisor \
  && chgrp staff /etc/supervisor/conf.d/supervisord.conf

EXPOSE 4730 8080

VOLUME ["/var/log/supervisor"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]