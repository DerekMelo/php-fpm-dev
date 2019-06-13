FROM php:7.3-fpm

RUN apt-get update

RUN apt-get install -y \
        libcurl4-openssl-dev \
        pkg-config libssl-dev

RUN docker-php-ext-install pdo_mysql

RUN apt-get install -y \
        zlib1g-dev \
        zip \
        libzip-dev \
  && docker-php-ext-install zip

RUN apt-get install -y git-core

RUN pecl install mongodb
RUN echo extension=mongodb.so >> /usr/local/etc/php/conf.d/pecl-php-mongodb.ini

RUN pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data