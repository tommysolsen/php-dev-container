FROM ubuntu:bionic

LABEL MAINTAINER="github.com/tommysolsen"

EXPOSE 80
WORKDIR /sites/site

# install nginx and php
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get install -y libssl-dev curl
RUN apt-get install php-xml -y
RUN apt-get install php-fpm -y
RUN apt-get install php-mysql -y
RUN apt-get install php-curl -y
RUN apt-get install nginx nginx-extras -y
RUN apt-get install ca-certificates -y
RUN apt-get install php-gd -y
RUN apt-get install php-mbstring -y
RUN apt-get install php-xdebug -y
RUN apt-get install php-redis -y
RUN apt-get install php-soap php-zip -y
RUN phpenmod xdebug
RUN phpenmod dom
RUN phpenmod xml
RUN phpenmod iconv 
RUN phpenmod zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer && rm composer-setup.php
ADD 000-default /etc/nginx/sites-enabled/default
ADD php.ini /etc/php/7.2/fpm/php.ini

# Install nodejs
RUN apt-get update
RUN echo "yes" | apt-get install -y build-essential libssl-dev wget
RUN wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz
RUN tar -xvvf node-v10.16.0-linux-x64.tar.xz
RUN mv node-v10.16.0-linux-x64 /opt/node
ENV PATH="${PATH}:/opt/node/bin"
RUN /opt/node/bin/npm install -g yarn

# Install other tools
RUN apt-get install -y git
RUN wget https://github.com/github/hub/releases/download/v2.12.0/hub-linux-amd64-2.12.0.tgz
RUN tar -xvvf hub-linux-amd64-2.12.0.tgz
RUN cd hub-linux-amd64-2.12.0 && ./install
RUN echo "alias git=hub" >> $HOME/.bashrc
RUN alias git=hub

# Install PHP CS fixer
RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/local/bin/php-cs-fixer
RUN chmod u+x /usr/local/bin/php-cs-fixer
RUN apt-get install -y php-codesniffer

ADD init.sh /init.sh
RUN chmod u+x /init.sh
CMD ["/init.sh"]
