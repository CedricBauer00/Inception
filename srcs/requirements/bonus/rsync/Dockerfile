FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y cron rsync mariadb-client

COPY ./tools/create_backup.sh ./tools/crontab.sh /

RUN chmod +x /create_backup.sh && chmod +x crontab.sh

RUN /crontab.sh

ENTRYPOINT ["cron", "-f"]