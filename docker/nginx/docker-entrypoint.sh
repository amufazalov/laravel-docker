#!/bin/bash

[ "$DEBUG" = "true" ] && set -x

VHOST_FILE="/etc/nginx/conf.d/default.conf"

[ ! -z "${USER_HOME}" ] && sed -i "s#!USER_HOME!#${USER_HOME}#" $VHOST_FILE
[ ! -z "${SERVER_ROOT}" ] && sed -i "s#!SERVER_ROOT!#${SERVER_ROOT}#" $VHOST_FILE
[ ! -z "${SERVER_SSL}" ] && sed -i "s#!SERVER_SSL!#${SERVER_SSL}#" $VHOST_FILE
[ ! -z "${VIRTUAL_HOST}" ] && sed -i "s#!VIRTUAL_HOST!#${VIRTUAL_HOST}#" $VHOST_FILE
[ ! -z "${VIRTUAL_PORT}" ] && sed -i "s#!VIRTUAL_PORT!#${VIRTUAL_PORT}#" $VHOST_FILE
[ ! -z "${UPLOAD_MAX_FILESIZE}" ] && sed -i "s#!UPLOAD_MAX_FILESIZE!#${UPLOAD_MAX_FILESIZE}#" $VHOST_FILE

SERVER_LISTEN="80";
if [ ! -z "${SERVER_SSL}" ] && [ "${SERVER_SSL}" == "on" ]
then
    if [ ! -z "${VIRTUAL_PORT}" ]
    then
        SERVER_LISTEN="${VIRTUAL_PORT} ssl";
    fi
fi
sed -i "s#!SERVER_LISTEN!#${SERVER_LISTEN}#" $VHOST_FILE

# Check if the nginx syntax is fine, then launch.
nginx -t

exec "$@"
