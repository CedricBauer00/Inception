#!/bin/bash
set -e

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
# echo "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> db.sql 
# echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" >> db.sql
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> db.sql 
echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" >> db.sql
# echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mysql -u root < db.sql
rm -f db.sql

sleep 2
service mariadb stop
sleep 2

exec mysqld_safe --datadir=/var/lib/mysql

# docker exec -it mariadb bash
# mysql -u root
# SELECT user, host, plugin, authentication_string, LENGTH(authentication_string) AS hash_length FROM mysql.user WHERE user='root';