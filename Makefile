COMPOSE=docker compose -f "./srcs/docker-compose.yml"

all: build up

build: 
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

clean:	down
	$(COMPOSE) down --volumes --rmi all

re: clean all

.PHONY: all build up down clean re