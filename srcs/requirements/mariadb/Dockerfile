FROM debian:buster
#Debian-Image

RUN apt-get update -y && apt-get install mariadb-server -y
#updating apt && installing mariadb

COPY db1.sql /docker-entrypoint=initdb.d/db1.sql

RUN sed -i 's/bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.conf

CMD ["/usr/bin/mysql_safe"]

