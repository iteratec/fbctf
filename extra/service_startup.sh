#!/bin/bash

set -e

if [[ -e /root/tmp/certbot.sh ]]; then
    /bin/bash /root/tmp/certbot.sh
fi

service hhvm restart
service nginx restart
service mysql restart
service memcached restart

chown www-data:www-data /var/run/hhvm/sock

if [ "$FBCTF_ADMIN_USER" = "" ]; then
	echo "The environment variable FBCTF_ADMIN_USER does not exist!"
elif [ "$FBCTF_ADMIN_PASSWORD" = "" ]; then
	echo "The environment variable FBCTF_ADMIN_PASSWORD does not exist"
else
	echo "Found the variables FBCTF_ADMIN_USER and FBCTF_ADMIN_PASSWORD -> reseting the admin user and password..."
   	source ./extra/lib.sh
   	set_admin ${FBCTF_ADMIN_USER} ${FBCTF_ADMIN_PASSWORD} ctf ctf fbctf /root
fi

while true; do
    if [[ -e /var/log/nginx/access.log ]]; then
        exec tail -F /var/log/nginx/access.log
    else
        exec sleep 10
    fi
done
