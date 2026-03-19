#!bin/bash

echo "Entered inti.sh script"

cp /index-static.html /var/www/html

echo "Nginx service running..."

exec nginx -g "daemon off;"
