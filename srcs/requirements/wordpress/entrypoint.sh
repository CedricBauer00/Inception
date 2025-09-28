# waiting for mariadb
echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 1
done
echo "MariaDB is ready!"

# wordpress configuration creating; if not existent
if [ ! -f wp-config.php ]; then
    echo "Creating WordPress configuration..."

    # creating wp-config.php from ep-config-sample.php
    cp wp-config-sample.php wp-config.php

    # setting database settings in wp-config.php
    sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php
    sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
    sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config.php
    sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config.php

    echo "WordPress configuration created!"
fi

# set permissions
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

# starting PHP-FPM
exec php-fpm8.2 -F
