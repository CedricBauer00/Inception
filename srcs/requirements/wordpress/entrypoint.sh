#!/bin/bash
echo "Waiting for MariaDB to be ready..."
# while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
#     sleep 1
# done
# echo "MariaDB is ready!"


sleep 20

cd /var/www/html

# wordpress configuration creating; if not existent
if [ ! -f wp-config.php ]; then
    echo "Creating WordPress configuration..."

    wp core download --allow-root
    # creating wp-config.php from ep-config-sample.php
	wp config create \
        	--dbname=$DB_NAME \
      		--dbuser=$DB_USER \
        	--dbpass=$DB_PASSWORD \
        	--dbhost=$WORDPRESS_DB_HOST \
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
        --user_pass=$wp_password \
        --allow-root

    echo "WordPress installed!"
fi

# set permissions
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

# starting PHP-FPM
exec php-fpm8.2 -F
