#!bin/bash

echo "Entered inti.sh script"

cp /README.html /var/www/html

exec nginx -g "daemon off;"
