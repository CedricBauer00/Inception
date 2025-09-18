FROM debian:bookworm
#Debian-Image der VM; iso 12

RUN apt-get update -y && apt-get install mariadb-server -y
#updating apt && installing mariadb

COPY db1.sql /docker-entrypoint-initdb.d/db1.sql

RUN sed -i 's/bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.conf

CMD ["/usr/bin/mysql_safe"]




# !!!COPILOT Copy, just note for later

# Ja, das fehlt dir noch!

# Was bedeutet das?
# Du sollst keine Passwörter oder User direkt im Dockerfile angeben.
# Stattdessen werden sensible Daten wie Datenbank-User und Passwörter als Umgebungsvariablen gesetzt – meist über eine .env-Datei und in docker-compose.yml.

# Beispiel:
# In deiner docker-compose.yml könntest du schreiben:

# Und in deiner .env:

# Vorteil:

# Passwörter sind nicht im Dockerfile sichtbar.
# Du kannst sie einfach ändern, ohne das Image neu zu bauen.
# Mehr Sicherheit und Flexibilität.
# Kurz:
# Du musst noch Umgebungsvariablen für User und Passwörter nutzen und diese im Container verwenden.