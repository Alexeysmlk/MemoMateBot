FROM php:8.4-fpm-bookworm

ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        curl \
        libpq-dev \
        libzip-dev \
        libicu-dev \
        libonig-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        bcmath \
        exif \
        gd \
        intl \
        mbstring \
        opcache \
        pcntl \
        pdo_pgsql \
        zip \
    && pecl install redis xdebug \
    && docker-php-ext-enable redis xdebug \
    && groupadd -g "${GID}" app \
    && useradd -m -u "${UID}" -g app -s /bin/bash app \
    && sed -ri 's/^user = www-data/user = app/' /usr/local/etc/php-fpm.d/www.conf \
    && sed -ri 's/^group = www-data/group = app/' /usr/local/etc/php-fpm.d/www.conf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/pear

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

COPY docker/php/conf.d/php.ini /usr/local/etc/php/conf.d/99-app.ini
COPY docker/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/99-xdebug.ini

WORKDIR /var/www/html

USER app
