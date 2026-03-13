#!/bin/bash
set -e #if exit code != 0 - abort

echo "Starting MariaDB initialisation..."

if [ ! -d "/var/lib/mysql/mysql" ]; then # folder der internen Datenbank (safes Users, permissions, ...) - if not existing, mariadb has never been initialised
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null 
fi
#--user=mysql creates database as linux user, not as root
# --datadir=/var/lib/mysql safes database files in this folder

service mariadb start # start, so SQL commands can be executed - process runs in background 

while ! mysqladmin ping --silent 2>/dev/null; do # checks if Mariadb is ready
    sleep 1
done

echo "setting up database and user..."

echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" >> db.sql # creates wordpress database if not existing
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> db.sql # creates database User, '@'%' -> everyone can connect, not only localhost
echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" >> db.sql # grants permissions to database
echo "FLUSH PRIVILEGES;" >> db.sql

mysql -u root < db.sql # SQL commands redirect into mysql - execute as root 
rm -f db.sql

sleep 2
service mariadb stop # stops for clean structure - will be restartet in exec
sleep 2

exec mysqld --datadir=/var/lib/mysql # process runs as PID1




# docker exec -it mariadb bash
# mysql -u root
# SELECT user, host, plugin, authentication_string, LENGTH(authentication_string) AS hash_length FROM mysql.user WHERE user='root';