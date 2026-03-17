FROM debian:bookworm 

RUN apt-get update -y && apt-get install -y \
    php php-fpm php-mysql wget curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer
RUN wget "https://www.adminer.org/latest.php" -O /var/www/adminer/index.php

EXPOSE 8080

#php server der direkte anfragen ueber port 4242 annimmt
RUN mkdir -p /run/php
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"] 