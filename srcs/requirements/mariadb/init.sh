#!/bin/bash
set -e

echo "Starting MariaDB initialisation..."
                                                                                                                                                  
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# MariaDB initing if neccessary

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

service mariadb start

sleep 10

echo "setting up database and user..."

# mysql -u root <<-EOSQL
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
# CREATE DATABASE IF NOT EXISTS wordpress;
# CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
# GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
# FLUSH PRIVILEGES;
# EOSQL

echo "here"
echo "db_password = ${DB_USER}"
echo "${DB_PASSWORD}"
echo "${DB_USER}"


# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'" >> db.sql
echo "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};" >> db.sql
echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';" >> db.sql 
echo "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DB_USER}'@'%';" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mysql < db.sql


echo "Database setup complete!"
sleep 2
service mariadb stop

echo "here2"
sleep 2
# FALSCH: exec mariadb --user=mysql
# RICHTIG:
exec mysqld --user=mysql
