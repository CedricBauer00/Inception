#!/bin/bash
echo "Waiting for MariaDB to be ready..."
# while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
#     sleep 1
# done
# echo "MariaDB is ready!"


sleep 5

cd /var/www/html

# wordpress configuration creating; if not existent
if [ ! -f wp-config.php ]; then
    echo "Creating WordPress configuration..."

    wp core download --allow-root

    # creating wp-config.php from ep-config-sample.php
    cp wp-config-sample.php wp-config.php

    # setting database settings in wp-config.php
    sed -i "s/database_name_here/database/g" wp-config.php
    sed -i "s/username_here/$DB_USER/g" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
    sed -i "s/localhost/mariadb/g" wp-config.php

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
