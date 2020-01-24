
FROM alpine:3.10

LABEL Description="Build & deploy Magento 2 with Deployer and Docker"

# trust this project public key to trust the packages.
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# make sure you can use HTTPS
RUN apk --no-cache --update add  \
    ca-certificates \
    openssh-client \
    rsync \
    unzip \
    php7 \
    php7-bcmath \
    php7-cli \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mysqlnd \
    php7-openssl \
    php7-pdo_mysql \
    php7-phar \
    php7-simplexml \
    php7-soap \
    php7-tokenizer \
    php7-xml \
    php7-xmlwriter \
    php7-xsl \
    php7-zip \
    && sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php7/php.ini

# Install tools
RUN wget https://getcomposer.org/installer && php installer --install-dir=/usr/local/bin --filename=composer
RUN composer global require hirak/prestissimo
RUN wget https://deployer.org/deployer.phar && mv deployer.phar /usr/local/bin/dep && chmod +x /usr/local/bin/dep

# Cleanup
RUN rm -rf /root/.composer/cache
