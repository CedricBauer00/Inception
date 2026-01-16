#!/bin/bash
set -e

echo "Starting MariaDB initialisation..."

# MariaDB initing if neccessary

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

service mariadb start

sleep 5

echo "setting up database and user..."

mysql -u root <<-EOSQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

echo "Database setup complerte!"

service mysql stop
exec mysqld --user=mysql
