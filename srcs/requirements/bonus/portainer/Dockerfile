FROM debian:bookworm

RUN apt-get update && apt-get install -y curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -o portainer.tar.gz && \
    tar -xzf portainer.tar.gz && \
    mv portainer /usr/local/bin/portainer && \
    rm portainer.tar.gz

EXPOSE 9000

ENTRYPOINT [ "portainer" ]
