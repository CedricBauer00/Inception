FROM debian:bookworm

RUN apt-get update -y && apt-get install -y redis-server \
    && rm -rf /var/lib/apt/lists/* 

RUN sed -i 's/bind 127.0.0.1 -::1/bind 0.0.0.0'

CMD ["redis server", "/etc/redis/redis.conf"]

