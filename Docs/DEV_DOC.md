# USER Documentation

To set up the environment from scratch, ensure you have Docker, Docker Compose, and GNU Make installed on you system. Clone the repository and review the configuration files in 'srcs/docker-compose.yml' and the secrets in 'srcs/secrets/'. Service-specific configurations are found in each service's 'tools/' directory.

To build and launch the project, run 'make' in the project root/ This will build all images and start all services using Docker Compose. To stop and remove all containers, volumes, and data, run 'make fclean'.

You can manage cointainers and volumes with the following commands:
- List running containers: 'docker ps'
- View logs for a service: 'docker logs -f <service-name>'
- Enter a running container: 'docker exec -it <service-name> bash'
- List Docker volumes: 'docker volumes ls'
- Rebuild a specific service: 'docker compose build <service-name>'

Project data is stored in Docker volumes, which are mapped to the 'data' directory on the hist (e.g. 'data/wordpress', 'data/mariadb', 'data/rsync'). This ensures persistence of website, database and backup data across container restarts or rebuilds.

All credentials and secrets are managed as files in 'srcs/secrets/'. If you change configuration or secret files, rebuild affected service for changes to take effect.