CREATE DATABASE wordpress;
CREATE USER 'wp_user'@'%' IDENTIFIED BY 'wp_pass';
GRANT ALL PRIVILEGES ON wordpress/* TO 'wp_user'@'%';
FLUSH PRIVILEGES;