FROM php:5.6.25-apache

# Install git and other packaes
RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install composer in /usr/lib folder
WORKDIR /usr/lib
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

# Install swiftmailer
RUN php /usr/lib/composer.phar require swiftmailer/swiftmailer @stable

# Install PHPMailer
RUN php /usr/lib/composer.phar require phpmailer/phpmailer @stable