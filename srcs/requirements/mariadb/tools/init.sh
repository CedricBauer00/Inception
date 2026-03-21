#!/bin/bash
set -e

MYSQL_PASSWORD=$(cat /run/secrets/mb_password)

echo "Starting MariaDB initialisation..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null 
fi

service mariadb start

while ! mysqladmin ping --silent 2>/dev/null; do
    sleep 1
done

echo "setting up database and user..."

echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" >> db.sql
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> db.sql
echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql


mysql -u root < db.sql
rm -f db.sql

sleep 2
service mariadb stop
sleep 2

echo "MariaDB is up and running..."

chown -R mysql:mysql /var/lib/mysql
exec mysqld --user=mysql --datadir=/var/lib/mysql
