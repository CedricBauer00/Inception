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

fclean: clean
	$(COMPOSE) down --volumes --rmi all --remove-orphans
	docker system prune -af

.PHONY: all build up down clean re