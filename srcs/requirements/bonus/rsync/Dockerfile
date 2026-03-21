FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y cron rsync mariadb-client

COPY ./tools/create_backup.sh ./tools/crontab.sh ./tools/entrypoint.sh / 

RUN chmod +x /create_backup.sh && chmod +x crontab.sh && chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]