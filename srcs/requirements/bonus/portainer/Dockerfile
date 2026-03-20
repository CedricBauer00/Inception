FROM debian:bookworm

RUN apt-get update && apt-get install -y curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# RUN curl -SL https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose \
#     && chmod +x /usr/local/bin/docker-compose

RUN curl -L https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -o portainer.tar.gz && \
    tar -xzf portainer.tar.gz && \
    mv portainer/portainer /usr/local/bin/portainer && \
    rm -rf portainer portainer.tar.gz

EXPOSE 9001

ENTRYPOINT [ "portainer", "--bind", ":9001", "--assets", "/portainer"]
