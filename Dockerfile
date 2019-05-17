FROM ubuntu:18.04

# Fix debconf warnings upon build
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update

RUN apt -y install \
 curl \
 git \
 openssh-client \
 rsync \
 software-properties-common \
 unzip

# Remove existing php installation(s)
RUN apt-get -y purge php7.*

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get -y --no-install-recommends install \
 php7.2-cli \
 php7.2-bcmath \
 php7.2-curl \
 php7.2-gd \
 php7.2-intl \
 php7.2-mbstring \
 php7.2-mysql \
 php7.2-soap \
 php7.2-xml \
 php7.2-xsl \
 php7.2-zip

# Cleanup
RUN apt-get autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require hirak/prestissimo

RUN curl -LO https://deployer.org/deployer.phar && mv deployer.phar /usr/local/bin/dep && chmod +x /usr/local/bin/dep