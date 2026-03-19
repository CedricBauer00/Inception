FROM debian:bookworm

WORKDIR /var/www/html

RUN apt-get update -y \
    && apt-get install -y php php-fpm php-mysql php-gd php-mbstring php-xml php-xml wget mariadb-client curl unzip \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz
# downloads and extracts the latest WordPress version into the working directory

COPY ./tools/php.ini /etc/php/8.2/fpm/php.ini
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

#COPY ./srcs/requirements/wordpress/ ./
# Kopiert den Inhalt des aktuellen Verzeichnisses (srcs/requirements/wordpress/) in das Arbeitsverzeichnis (/var/www/html) im Container

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's/listen = .*/listen = 9000/' /etc/php/*/fpm/pool.d/www.conf \
    && sed -i 's/listen.owner = .*/listen.owner = www-data/' /etc/php/*/fpm/pool.d/www.conf \
    && sed -i 's/listen.group = .*/listen.group = www-data/' /etc/php/*/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT [ "/entrypoint.sh" ]