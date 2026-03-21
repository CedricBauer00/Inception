#!/bin/bash

set -e

DB_PASSWORD=$(cat /run/secrets/mb_password)
WP_PASSWORD=$(cat /run/secrets/wp_password)

echo "Waiting for MariaDB to be ready..."
echo "Waiting for MariaDB connection on host: $WORDPRESS_DB_HOST ..."

while ! mariadb -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$DB_PASSWORD $WORDPRESS_DB_NAME --silent; do
    echo "MariaDB is not reachable yet... Retrying in 3s"
    sleep 3
done

cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "Creating WordPress configuration..."

    # creating wp-config.php from ep-config-sample.php
	wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root \
        --extra-php <<-EOF
        define('WP_REDIS_HOST', 'redis-cache');
        define('WP_REDIS_PORT', 6379);
EOF

    wp core install \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    wp user create \
        $WP_USER \
        $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PASSWORD \
        --allow-root

    wp plugin install redis-cache --allow-root

    wp plugin activate redis-cache --allow-root

    wp redis enable --allow-root

    echo "WordPress installed!"
fi

# touch /var/www/html/FTP-Delete.txt
# echo "Test file for ftp" > /var/www/html/FTP-Delete.txt

# set permissions
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

echo "Connected!"

# starting PHP-FPM
exec php-fpm8.2 -F
