#!/bin/bash
echo "Waiting for MariaDB to be ready..."
echo "Waiting for MariaDB connection on host: $WORDPRESS_DB_HOST ..."
# while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
#     sleep 1
# done
# echo "MariaDB is ready!"


while ! mariadb -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME --silent; do
    echo "MariaDB is not reachable yet... Retrying in 3s"
    sleep 3
done

cd /var/www/html

# wordpress configuration creating; if not existent
if [ ! -f wp-config.php ]; then
    echo "Creating WordPress configuration..."

    wp core download --allow-root
    # creating wp-config.php from ep-config-sample.php
	wp config create \
        	--dbname=$WP_DB_NAME \
      		--dbuser=$WP_DB_USER \
        	--dbpass=$WP_DB_PASSWORD \
        	--dbhost=$WP_DB_HOST \
        	--allow-root

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

    echo "WordPress installed!"
fi

# set permissions
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

echo "Connected"

# starting PHP-FPM
exec php-fpm8.2 -F
