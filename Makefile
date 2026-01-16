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

remove:
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	@if [ -n "$$(docker images -qa)" ]; then docker rmi -f $$(docker images -qa); fi
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@if [ -n "$$(docker network ls -q)" ]; then docker network rm $$(docker network ls -q) 2>/dev/null || true; fi

.PHONY: all build up down clean re remove