FROM debian:bookworm

RUN apt-get update -y && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY ./www/ /var/www/html/
COPY ./static-nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]