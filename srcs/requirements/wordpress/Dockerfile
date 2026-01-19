FROM debian:bookworm


WORKDIR /var/www/html
# all following commands are executed in /var/www/html


# install php, php-fpm, php-mysql, wget, mariadb-client, curl and unzip
# php-fpm - PHP FastCGI Process Manager
# php-mysql - PHP-Extension fuer MySQL/MariaDB
# wget, curl, unzip - tools for downloading, plugins, themes, etc.
# mariadb-client - to execute SQL-commands in container
RUN apt-get update -y \
    && apt-get install -y php php-fpm php-mysql php-gd php-mbstring php-xml php-xml wget mariadb-client curl unzip \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz
# downloads and extracts the latest WordPress version into the working directory

COPY php.ini /etc/php/8.2/fpm/php.ini
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
# COPY . ./
# SO???

#COPY ./srcs/requirements/wordpress/ ./
# Kopiert den Inhalt des aktuellen Verzeichnisses (srcs/requirements/wordpress/) in das Arbeitsverzeichnis (/var/www/html) im Container

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's/listen = .*/listen = 9000/' /etc/php/*/fpm/pool.d/www.conf \
    && sed -i 's/listen.owner = .*/listen.owner = www-data/' /etc/php/*/fpm/pool.d/www.conf \
    && sed -i 's/listen.group = .*/listen.group = www-data/' /etc/php/*/fpm/pool.d/www.conf
# Aendert die Listen-Port-Konfiguration in der PHP-FPM Konfigurationsdatei auf 9000
EXPOSE 9000

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["php-fpm", "-F"]  
# Startet den PHP FastCGI Process Manager im Vordergrund
# -F = Forground-Modus, damit der Container nicht sofort beendet wird