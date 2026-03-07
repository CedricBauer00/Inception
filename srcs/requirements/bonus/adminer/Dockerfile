FROM debian:bookworm 

RUN apt-get update -y && apt-get install -y \
    php php-fpm php-mysql wget curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer
RUN wget "htpps://www.adminer.org/latest.php" -O /var/www/adminer/index.php
RUN sed -i 's./listen = .*listen = 8080/' /etc/php/*fpm/pool.d/www.conf