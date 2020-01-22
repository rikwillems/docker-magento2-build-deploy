
FROM alpine:3.10

LABEL Description="Build & deploy Magento 2 with Deployer and Docker"

# trust this project public key to trust the packages.
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# make sure you can use HTTPS
RUN apk --update add ca-certificates

# Install packages
RUN apk --update --no-cache add \
    curl \
    git \
    openssh-client \
    rsync \
    unzip

# Install php
RUN apk --no-cache add \
    php7 \
    php7-cli \
    php-curl \
    php7-gd \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-phar \
    php7-soap \
    php7-xml \
    php7-xsl \
    php7-zip

# Install tools
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer global require hirak/prestissimo
RUN curl -LO https://deployer.org/deployer.phar && mv deployer.phar /usr/local/bin/dep && chmod +x /usr/local/bin/dep
