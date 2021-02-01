FROM php:7.4.14-apache

RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    git \
    vim \
    wget \
    lynx \
    psmisc \
    libgmp-dev \
    libzip-dev \
  && apt-get clean

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/
RUN pecl install mcrypt-1.0.3
RUN docker-php-ext-enable mcrypt
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install -j$(nproc) \
    gd \
    intl \
    pdo_mysql \
    xsl \
    zip \
    opcache \
    bcmath \
    soap \
    sockets \
    bcmath \
    gmp
ADD php.ini /usr/local/etc/php/conf.d/888-docker-php.ini
ADD start.sh /start.sh

RUN usermod -u 1000 www-data; \
  a2enmod rewrite; \
  curl -o /tmp/composer-setup.php https://getcomposer.org/installer; \
  curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig; \
  php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }"; \
  php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer; \
	rm /tmp/composer-setup.php; \
  chmod +x /usr/local/bin/composer; \
  curl -o n98-magerun2.phar http://files.magerun.net/n98-magerun2-latest.phar; \
  chmod +x ./n98-magerun2.phar; \
  chmod +x /start.sh; \
  chmod +r /credis.php; \
  mv n98-magerun2.phar /usr/local/bin/; \
  mkdir -p /root/.composer

CMD ["/start.sh"]
