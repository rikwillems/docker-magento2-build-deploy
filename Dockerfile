
FROM alpine:3.9

LABEL Description="Build & deploy Magento 2 with Deployer and Docker"

# trust this project public key to trust the packages.
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# make sure you can use HTTPS
RUN apk --update add ca-certificates

# add the repository, make sure you replace the correct versions if you want.
RUN echo "https://dl.bintray.com/php-alpine/v3.9/php-7.3" >> /etc/apk/repositories

# Install packages
RUN apk --no-cache add \
  php7 \
  php7-mysqli \
  php7-cli \
   php7-bcmath \
   php7-curl \
   php7-gd \
   php7-intl \
   php7-mbstring \
   php7-soap \
   php7-xml \
   php7-xsl \
   php7-zip
