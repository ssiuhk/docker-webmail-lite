FROM ubuntu:bionic

# installing packages and dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install wget \
    unzip \
    apache2 \
    mariadb-client \
    iputils-ping \
    curl \
    openssl \
    vim \
    jq \
    libapache2-mod-php \
    php \
    php-common \
    php-curl \
    php-fpm \
    php-cli \
    php-mysqlnd \
    php-dev \ 
    php-mbstring \ 
    libmcrypt-dev \
    gcc \
    make \
    autoconf \
    libc-dev \
    pkg-config && \
    apt-get clean all && \
    echo '\n' | pecl install mcrypt-1.0.1 && \
    echo "extension=mcrypt.so" | tee -a /etc/php/7.2/apache2/conf.d/mcrypt.ini && \
    a2enmod ssl && \
    a2enmod rewrite && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    wget -O /tmp/tini.deb https://github.com/krallin/tini/releases/download/v0.18.0/tini_0.18.0-amd64.deb && \
    dpkg -i /tmp/tini.deb

RUN rm -rf /tmp/alwm && \
    mkdir -p /tmp/alwm && \    
    wget -P /tmp/alwm https://afterlogic.org/download/webmail_php.zip && \
    unzip -q /tmp/alwm/webmail_php.zip -d /tmp/alwm/ && \
    rm -rf /tmp/alwm/webmail_php.zip /var/www/html && \
    cp -r /tmp/alwm /var/www/html && \
    chown www-data.www-data -R /var/www/html && \
    rm -rf /tmp/alwm 


# setting up default apache config
ADD apache.conf /etc/apache2/sites-available/000-default.conf

# Start-up scripts
ADD entrypoint.sh /entrypoint.sh
RUN chown root:root /entrypoint.sh && \
    chmod 755 /entrypoint.sh

EXPOSE 80 443

#USER www-data

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]

HEALTHCHECK CMD curl --fail http://localhost || exit 1

LABEL MAINTAINER="AfterLogic Support <support@afterlogic.com>, modified by Sam Siu <23556929+ssiuhk@users.noreply.github.com>"

