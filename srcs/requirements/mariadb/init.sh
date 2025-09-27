# bash script

service mysql start

mysql -u root <<-EOSQL
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

exec mysqld
