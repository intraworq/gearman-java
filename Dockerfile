FROM java:8-jre

MAINTAINER "Bolek Tekielski" bolek@vault13.pl

RUN apt-get update \
  	&& apt-get install --no-install-recommends supervisord \
  	&& LINK = $(wget -qO- https://raw.githubusercontent.com/intraworq/gearman-java/master/current.version.link) \
  	&& mkdir -p /opt/gearman/{etc,bin} \
  	&& wget -q -O /opt/gearman/bin/gearman-server.jar $(LINK)

COPY config.yml /opt/gearman/etc/config.yml
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/log/supervisor \
  && chgrp staff /var/log/supervisor \
  && chmod g+w /var/log/supervisor \
  && chgrp staff /etc/supervisor/conf.d/supervisord.conf
  
EXPOSE 4730 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]