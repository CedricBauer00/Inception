FROM debian:bookworm

# install nginx and openssl
RUN apt-get update -y && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# includ certificate and key; because secrets folder mounted into docker-compose.yml

# include nginx configuration file

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443


CMD ["nginx", "-g", "daemon off;"]


# NGINX Dockerfile
# Gut:

# Basis-Image und Installation.
# Zertifikate und Konfiguration werden kopiert.
# Startbefehl ist korrekt.
# Verbesserung:

# Die COPY-Pfad-Angaben sind eventuell falsch.
# Beispiel:
# → Der Build-Kontext ist normalerweise das Verzeichnis, in dem du docker build ausführst.
# → Nutze relative Pfade ab Build-Kontext, z.B. COPY [nginx.crt](http://_vscodecontentref_/0) /etc/ssl/private/
# Prüfe, ob die Zertifikate wirklich im Build-Kontext liegen.
