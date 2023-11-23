FROM php:8.2-cli

RUN apt-get update && \
    apt-get install -y \
    libicu-dev \
    zlib1g-dev \
    git \
    unzip \
    libzip-dev \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libmagickwand-dev \
    libonig-dev \
    libsodium-dev --no-install-recommends

RUN docker-php-ext-install \
    bcmath \
    intl \
    mbstring \
    pcntl \
    pdo \
    soap \
    sodium \
    zip \
    gd

RUN pecl install \
    apcu \
    imagick \
    memcached

RUN docker-php-ext-enable \
    apcu \
    imagick \
    memcached

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
