FROM debian:bookworm

RUN apt-get update -y && apt-get install -y redis-server \
    && rm -rf /var/lib/apt/lists/* 

RUN sed -i -E 's/^bind .*/bind 0.0.0.0/' /etc/redis/redis.conf

CMD ["redis-server", "--protected-mode no"]