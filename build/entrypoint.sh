#!/bin/bash
set -ex

if [ "$#" -eq 0 ]; then

    if [ ! -z ${PHP_UPLOAD_MAX_FILESIZE} ] && [ ! -z ${PHP_POST_MAX_SIZE} ]; then
        sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
            -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php/7.2/apache2/php.ini
    fi

    if [ ! -e /etc/ssl/certs/webmail_cert.pem ] || [ ! -e /etc/ssl/private/webmail_key.key ]; then
        openssl req -new -newkey rsa:4096 -x509 -days 1096 -nodes \
            -keyout /etc/ssl/private/webmail_key.key \
            -out /etc/ssl/certs/webmail_cert.pem \
            -subj "/C=US/O=Example.com/OU=Webmail/CN=webmail.example.com"
    fi

    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hafterlogic-db -e "CREATE DATABASE IF NOT EXISTS afterlogic;"

    if [ ! -z ${MYSQL_ROOT_PASSWORD} ]; then
        tmp=$(mktemp)
        jq --arg mysqlrootpw "$MYSQL_ROOT_PASSWORD" '.DBPassword= [ $mysqlrootpw, "string" ]' /var/www/html/data/settings/config.json > "$tmp" && \
        cat "$tmp" > /var/www/html/data/settings/config.json && rm -f "$tmp"
    fi

    chown www-data.www-data /var/www/html/data/settings/config.json && \
    chmod 600 /var/www/html/data/settings/config.json

    source /etc/apache2/envvars
    exec apache2 -D FOREGROUND

else

    "$@"

fi

