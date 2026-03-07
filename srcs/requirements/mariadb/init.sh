#!/bin/bash
set -e

echo "Starting MariaDB initialisation..."
                                                                                                                                                  
# mkdir -p /run/mysqld
# chown -R mysql:mysql /run/mysqld

sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# MariaDB initing if neccessary

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi
    # service mariadb start
mysqld_safe --datadir=/var/lib/mysql &

while ! mysqladmin ping --silent 2>/dev/null; do
    sleep 1
done

echo "setting up database and user..."

echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" >> db.sql
echo "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> db.sql 
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" >> db.sql
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> db.sql 
echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" >> db.sql
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');" >> db.sql
# echo "ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> db.sql
# echo "DROP USER IF EXISTS 'root'@'localhost';" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mysql -u root < db.sql
rm -f db.sql

sleep 2
# service mariadb stop
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
sleep 2

# else
#     echo "Mariadb ist already initialized, skipping setup."
# fi

# exec mysqld --user=mysql
exec mysqld_safe --datadir=/var/lib/mysql

# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> db.sql

# docker exec -it mariadb bash
# mysql -u root
# SELECT user, host, plugin, authentication_string, LENGTH(authentication_string) AS hash_length FROM mysql.user WHERE user='root';