#! /bin/bash

echo "Rsync: backup is being cereated..."

MYSQL_PASSWORD=$(cat /run/secrets/mb_password)

echo "USER: $MYSQL_USER"
echo "DB: $MYSQL_DATABASE"
echo "PW: $MYSQL_PASSWORD"
mkdir -p /home/backup/wordpress /home/backup/database

rsync -a /var/www/html/ /home/backup/wordpress/
mysqldump -h mariadb -P 3306 \
    -u ${MYSQL_USER} \
    -p${MYSQL_PASSWORD} \
    ${MYSQL_DATABASE} > /home/backup/database/dp_backup.sql

echo "Rsync: Created backup!"