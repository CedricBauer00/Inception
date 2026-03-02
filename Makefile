COMPOSE=docker compose -f "./srcs/docker-compose.yml"

all: build up

#folder structure auf host
#safety, die Daten separat zu halten, um ausversehenes loeschen im working environment zu preventen
prepare_dirs:
	mkdir -p /home/cbauer/data/wordpress
	mkdir -p /home/cbauer/data/mariadb

build: prepare_dirs
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

clean:	down
	$(COMPOSE) down --volumes --rmi all
#--volumes // sollen Datenbank inhalte auch geloescht werden?

re: clean all

fclean: clean
	$(COMPOSE) down --volumes --rmi all --remove-orphans
	docker system prune -af

	sudo rm -rf /home/cbauer/data/wordpress
	sudo rm -rf /home/cbauer/data/mariadb
	
#prune deletes unused data
# -af delte all unused images - force

remove:
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	@if [ -n "$$(docker images -qa)" ]; then docker rmi -f $$(docker images -qa); fi
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@if [ -n "$$(docker network ls -q)" ]; then docker network rm $$(docker network ls -q) 2>/dev/null || true; fi
# gibt alle Container-Ids zurueck, even stopped ones (-a) 
# -n sagt "wenn text nicht empty" ?

.PHONY: all build up down clean re remove


