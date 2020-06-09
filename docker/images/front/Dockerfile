FROM php:7.4-apache

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY php.ini /usr/local/etc/php/php.ini

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/app
