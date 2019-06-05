FROM ubuntu:latest

LABEL MAINTAINER="github.com/tommysolsen"

EXPOSE 80
WORKDIR /sites/site

RUN apt-get update
RUN apt-get install php-fpm -y
RUN apt-get install php-mysql -y
RUN apt-get install php-curl -y
RUN apt-get install nginx nginx-extras -y
RUN apt-get install ca-certificates -y
RUN apt-get install php-gd -y

ADD 000-default /etc/nginx/sites-enabled/default
ADD php.ini /etc/php/7.2/fpm/php.ini

ADD init.sh /init.sh
RUN chmod u+x /init.sh
CMD ["/init.sh"]