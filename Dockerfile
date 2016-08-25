FROM php:5.6.25-apache

# Install git and other packaes
RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install composer in /usr/lib folder
WORKDIR /usr/lib
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

# Install swiftmailer
RUN php /usr/lib/composer.phar require swiftmailer/swiftmailer @stable
