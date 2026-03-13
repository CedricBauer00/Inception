FROM debian:bookworm

RUN apt-get update -y && apt-get install mariadb-server -y

RUN sed -i 's/bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
# mariadb usually listens only to 127.0.0.1 (localhost), -> listens to alle interfaces - alle container koennen zugreifen - wordpress kann sich connecten
COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3306

ENTRYPOINT ["/init.sh"]
