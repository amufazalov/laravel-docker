FROM php:8.1-fpm

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libzip-dev \
    libxslt1-dev \
    libonig-dev \
    sendmail-bin \
    sendmail \
    sudo \
    cron \
    rsyslog \
    default-mysql-client \
    git \
    redis-tools \
    zip \
  && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
  && docker-php-ext-install \
    dom \
    gd \
    intl \
    mbstring \
    pcntl \
    pdo_mysql \
    xsl \
    zip \
    bcmath \
    soap \
    sockets \
  && pecl install -o -f xdebug \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install Node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install nodejs -y

# Create privilege user
RUN addgroup --gid 1000 docker && \
    adduser --uid 1000 --ingroup docker --home /var/www/laravel --shell /bin/bash --disabled-password --gecos "" docker

# Install Mhsendmail

RUN curl --location --output /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
  && chmod +x /usr/local/bin/mhsendmail

ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
ADD etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini
ADD etc/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

# VOLUME /var/www/laravel
WORKDIR /var/www/laravel

RUN mkdir /sock

CMD ["php-fpm", "-R"]
