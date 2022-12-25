#!/bin/bash

[ "$DEBUG" = "true" ] && set -x

# Configure Sendmail if required
if [ "$ENABLE_SENDMAIL" == "true" ]; then
    /etc/init.d/sendmail start
fi

# Configure mailhog if required
if [ "$ENABLE_MAILHOG" == "true" ]; then
    echo "sendmail_path = \"/usr/local/bin/mhsendmail --smtp-addr='mailhog:1025'\"" | sudo tee /usr/local/etc/php/conf.d/zz-mail.ini
fi

# Substitute in php-fpm.conf values
CONF_FILE="/usr/local/etc/php-fpm.conf"
[ ! -z "${PHP_MEMORY_LIMIT}" ] && sed -i "s#!PHP_MEMORY_LIMIT!#${PHP_MEMORY_LIMIT}#" $CONF_FILE
[ ! -z "${UPLOAD_MAX_FILESIZE}" ] && sed -i "s#!UPLOAD_MAX_FILESIZE!#${UPLOAD_MAX_FILESIZE}#" $CONF_FILE
[ ! -z "${SERVER_ROOT}" ] && sed -i "s#!SERVER_ROOT!#${SERVER_ROOT}#" $CONF_FILE

[ "$PHP_ENABLE_XDEBUG" = "true" ] && \
    docker-php-ext-enable xdebug && \
    echo "Xdebug is enabled"

exec "$@"
