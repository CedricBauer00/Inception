# File Transfer Protocol

FROM debian:bookworm

# vsftpd install (Very Secure FTP Daemon) 
# secure ftp program for Linux
# neccessary for running Linux
RUN apt-get update -y && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#Standartport fuer FTP
EXPOSE 21 21100-21110
# 21 Datenkanal - Steuerkanal
# 21100-21100 Datenkanal - data transfer(up/downloads)

ENTRYPOINT ["/entrypoint.sh"]