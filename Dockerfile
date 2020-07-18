FROM alpine:3.8
RUN apk add --no-cache \
    php5-opcache \
    php5-xsl \
    php5-zip \
    php5-pspell \
    php5-shmop \
    php5-sockets \
    php5-sqlite3 \
    php5-sysvmsg \
    php5-sysvsem \
    php5-sysvshm \
    php5-xml \
    php5-xmlreader \
    php5-openssl \
    php5-pdo \
    php5-pdo_mysql \
    php5-pdo_pgsql \
    php5-pdo_sqlite \
    php5-pgsql \
    php5-phar \
    php5-posix \
    php5-gettext \
    php5-gmp \
    php5-iconv \
    php5-imap \
    php5-intl \
    php5-json \
    php5-mcrypt \
    php5-mysql \
    php5-mysqli \
    php5-bz2 \
    php5-curl \
    php5-dom \
    php5-exif \
    php5-ftp \
    php5-gd \
    php5-apache2 \
    php5-bcmath \
    php5-pear \
    php5-apcu \
    php5-cli \
    php5-ctype \
    apache2-ssl && \
    mkdir -p /srv/www /run/apache2 && \
    chown apache:www-data /srv/www && \
    sed -ri \
        -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' \
        -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' \
        -e 's!^(\s*TransferLog)\s+\S+!\1 /proc/self/fd/1!g' \
        "/etc/apache2/httpd.conf" \
        "/etc/apache2/conf.d/ssl.conf" && \
    wget -q https://getcomposer.org/installer -O - | php5 -- --install-dir=/usr/bin --filename=composer

COPY ./apache/ /etc/apache2/conf.d/
WORKDIR /srv/www
VOLUME ["/srv/www"]
EXPOSE 80 443
CMD /usr/sbin/httpd -D FOREGROUND
