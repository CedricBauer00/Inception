FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y cron rsync mariadb-client

COPY ./tools/backup.sh ./tools/setup.sh /

RUN chmod +x /backup.sh && chmod +x setup.sh

RUN setup.sh

ENTRYPOINT ["cron", "-f"]