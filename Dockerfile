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
 php7.3-cli \
 php7.3-bcmath \
 php7.3-curl \
 php7.3-gd \
 php7.3-intl \
 php7.3-mbstring \
 php7.3-mysql \
 php7.3-soap \
 php7.3-xml \
 php7.3-xsl \
 php7.3-zip

# Cleanup
RUN apt-get autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require hirak/prestissimo

RUN curl -LO https://deployer.org/deployer.phar && mv deployer.phar /usr/local/bin/dep && chmod +x /usr/local/bin/dep
