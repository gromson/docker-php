#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:jessie

# persistent / runtime deps
ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev \
		file \
		g++ \
		gcc \
		libc-dev \
		libpcre3-dev \
		make \
		pkg-config \
		re2c
RUN apt-get update && apt-get install -y \
		$PHPIZE_DEPS \
		ca-certificates \
		curl \
		libedit2 \
		libsqlite3-0 \
		libxml2 \
		xz-utils \
		libfcgi-dev \
		libfcgi0ldbl \
		libjpeg62-turbo-dbg \
		libmcrypt-dev \
		libc-client2007e \
		libc-client2007e-dev \
		libc-client-dev \
		libbz2-dev \
		libjpeg-dev \
		libpng12-dev \
		libfreetype6-dev \
		libkrb5-dev \
		libpq-dev \
		libxslt-dev \
		libxslt1-dev \
		libxslt1.1 \
		openssl \
		libssl-dev \
		pkg-config \
		libexpat1 \
		libexpat1-dev \
		libicu-dev \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

##<autogenerated>##
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data
##</autogenerated>##

# Apply stack smash protection to functions using local buffers and alloca()
# Make PHP's main executable position-independent (improves ASLR security mechanism, and has no performance impact on x86_64)
# Enable optimization (-O2)
# Enable linker optimization (this sorts the hash buckets to improve cache locality, and is non-default)
# Adds GNU HASH segments to generated executables (this is used if present, and is much faster than sysv hash; in this configuration, sysv hash is also generated)
# https://github.com/docker-library/php/issues/272
ENV PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2"
ENV PHP_CPPFLAGS="$PHP_CFLAGS"
ENV PHP_LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie"

ENV GPG_KEYS 1729F83938DA44E27BA0F4D3DBDB397470D12172 B1B44D8F021E4E2D6021E995DC9FF8D3EE5AF27F

ENV PHP_VERSION 7.2.5
ENV PHP_URL="https://secure.php.net/get/php-7.2.5.tar.xz/from/this/mirror" PHP_ASC_URL="https://secure.php.net/get/php-7.2.5.tar.xz.asc/from/this/mirror"
ENV PHP_SHA256="af70a33b3f7a51510467199b39af151333fbbe4cc21923bad9c7cf64268cddb2" PHP_MD5=""

RUN set -xe; \
	\
	fetchDeps=' \
		wget \
	'; \
	if ! command -v gpg > /dev/null; then \
		fetchDeps="$fetchDeps \
			dirmngr \
			gnupg2 \
		"; \
	fi; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
	\
	mkdir -p /usr/src; \
	cd /usr/src; \
	\
	wget -O php.tar.xz "$PHP_URL"; \
	\
	if [ -n "$PHP_SHA256" ]; then \
		echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
	fi; \
	if [ -n "$PHP_MD5" ]; then \
		echo "$PHP_MD5 *php.tar.xz" | md5sum -c -; \
	fi; \
	\
	if [ -n "$PHP_ASC_URL" ]; then \
		wget -O php.tar.xz.asc "$PHP_ASC_URL"; \
		export GNUPGHOME="$(mktemp -d)"; \
		for key in $GPG_KEYS; do \
			gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
		done; \
		gpg --batch --verify php.tar.xz.asc php.tar.xz; \
		rm -rf "$GNUPGHOME"; \
	fi; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps

COPY docker-php-source /usr/local/bin/

RUN set -xe \
	&& buildDeps=" \
		$PHP_EXTRA_BUILD_DEPS \
		libcurl4-openssl-dev \
		libedit-dev \
		libsqlite3-dev \
		libssl-dev \
		libxml2-dev \
		zlib1g-dev \
	" \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	\
	&& export CFLAGS="$PHP_CFLAGS" \
		CPPFLAGS="$PHP_CPPFLAGS" \
		LDFLAGS="$PHP_LDFLAGS" \
	&& docker-php-source extract \
	&& cd /usr/src/php \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& debMultiarch="$(dpkg-architecture --query DEB_BUILD_MULTIARCH)" \
# https://bugs.php.net/bug.php?id=74125
	&& if [ ! -d /usr/include/curl ]; then \
		ln -sT "/usr/include/$debMultiarch/curl" /usr/local/include/curl; \
	fi \
	&& ./configure \
		--build="$gnuArch" \
		--with-config-file-path="$PHP_INI_DIR" \
		--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
		--disable-cgi \
		--disable-rpath \
		--enable-ftp \
		--enable-mbstring \
		--enable-mysqlnd \
		--enable-inline-optimization \
		--enable-gd-native-ttf \
		--enable-opcache \
		--enable-fpm \
		--enable-sockets \
		--enable-sysvsem \
		--enable-sysvshm \ 
		--enable-pcntl \
		--enable-mbregex \ 
		--enable-exif \
		--enable-bcmath \
		--enable-intl \
		--enable-zip \
		--enable-soap \
		--enable-calendar \
		--with-curl \
		--with-libedit \
		--with-openssl \
		--with-zlib \
		--with-pdo-pgsql \
		--with-zlib-dir \
		--with-freetype-dir \
		--with-libxml-dir="/usr/lib/$debMultiarch" \ 
		--with-mcrypt \
		--with-zlib \
		--with-gd \
		--with-pgsql \
		--with-bz2 \
		--with-mhash \
		--with-pdo-mysql \
		--with-mysqli \
		--with-jpeg-dir=/usr \
		--with-png-dir=/usr \
		#Cannot find imap library (libc-client.a). Please check your c-client installation.
		#--with-imap=/usr/lib64 \
		--with-imap-ssl \
		--with-kerberos \
		--with-gettext \
		--with-xmlrpc \
		--with-xsl \
		--with-pcre-regex=/usr \
		--with-libdir="lib/$debMultiarch" \
		$PHP_EXTRA_CONFIGURE_ARGS \
	&& make -j "$(nproc)" \
	&& make install \
	&& { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
	&& make clean \
	&& cd / \
	&& docker-php-source delete \
	\
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps

# Install debug applications
RUN apt-get update \
	&& apt-get -y install\
	mc \
	nano \
	vim

# Install pecl libruary
RUN \
	apt-get update \
	&& apt-get install -y \
	libpq5 \
	libpng12-0 \
	libpng12-dev \
	libfreetype6 \
	libfreetype6-dev \
	pkg-config \
	libjpeg62 \
	openssl \ 
	libssl-dev \
	pkg-config

# Install pecl dependency	
RUN pecl update-channels \
	&& rm -rf /tmp/pear ~/.pearrc
# Install pecl dependency
RUN \
	pecl install mongodb \
	&& pecl install https://pecl.php.net/get/dbase-7.0.0beta1.tgz \
	&& pecl install redis \
	&& pecl install xdebug

COPY docker-php-ext-* docker-php-entrypoint /usr/local/bin/

# Install wkhtmltopdf dependency
RUN \
	apt-get update \
	&& apt-get install -y \
	libxrender1 \
	libxrender-dev \
	libfontconfig1 \
	libfontconfig1-dev \
	libxext6 \
	libxext-dev \
	libjpeg62 \
	libjpeg-dev

ENTRYPOINT ["docker-php-entrypoint"]

WORKDIR /var/www

RUN set -ex \
	&& cd /usr/local/etc \
	&& if [ -d php-fpm.d ]; then \
		# for some reason, upstream's php-fpm.conf.default has "include=NONE/etc/php-fpm.d/*.conf"
		sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
		cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
	else \
		# PHP 5.x doesn't use "include=" by default, so we'll create our own simple config that mimics PHP 7+ for consistency
		mkdir php-fpm.d; \
		cp php-fpm.conf.default php-fpm.d/www.conf; \
		{ \
			echo '[global]'; \
			echo 'include=etc/php-fpm.d/*.conf'; \
		} | tee php-fpm.conf; \
	fi \
	&& { \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; \
		echo '[www]'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
	} | tee php-fpm.d/docker.conf \
	&& { \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = [::]:9000'; \
	} | tee php-fpm.d/zz-docker.conf

RUN pecl install grpc

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

EXPOSE 9000
CMD ["php-fpm"]
##</autogenerated>##
