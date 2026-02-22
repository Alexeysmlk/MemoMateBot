FROM dunglas/frankenphp:1-php8.4-bookworm AS base

ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=noninteractive

# Build dependencies for PHP extensions used by Laravel runtime.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libonig-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Core PHP extensions for Laravel + PostgreSQL + Redis workloads.
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
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
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/pear

# Container user matching host UID/GID to avoid volume permission issues.
RUN groupadd -g "${GID}" app \
    && useradd -m -u "${UID}" -g app -s /bin/bash app

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

COPY docker/php/conf.d/php.ini /usr/local/etc/php/conf.d/99-app.ini
COPY docker/caddy/Caddyfile /etc/caddy/Caddyfile

WORKDIR /var/www/html
USER app

FROM base AS dev

USER root

# Developer tooling kept out of the production-oriented base stage.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        git \
        unzip \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -rf /tmp/pear

COPY docker/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/99-xdebug.ini

USER app
