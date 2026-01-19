*This project hast been created as part of the 42 curriculum by cbauer*

# Inception - Docker Network Infrastructure

## Description

This prject named **inception** is about deepening your knowledge about system administration by using Docker. You will create a small infrastructure containing different sercives with specific rules, given by the subject, by writing Dockerfiles and orhcestrating them using Docker compose. The different services you are using are NGINX, Wordpress and MariaDB, which will all be implemented in seperate Docker containers. The basic goal is to create a personal web server setup with those three services, which will be connected via a custom Docker network.

## Instructions

### Prerequisites
- Docker Engine
- Docker Compose 
- Make

### Installation & Execution
1. Clone the repository: 
```bash
git clone "repository URL"
cd Inception
```

2. Setup environment variables:
- Ensure `.env` is present in `srcs` folder
- Ensure that the secrets folder ist not containing any credentials

3. Build and launch the infrastructure:
```bash
make
```
-b y running make all of the Docker images will be built and the containers will be started by the `docker-compose.yml`

4. Domain Setup
- You will have to add following line to the `/etc/hosts` file and replace `login` with you username
```
127.0.0.1 login.42.fr
```

5. Acess the network:
- Open the browser and enter the domain, so you will be connected to `https://login.42.fr`

## Project Description

### Docker & Sources

We are using Docker to containerize the services. As previously mentioned the services run in isolated containers which are orchestrated and managed by the `docker-compose.yml` file. The dokcer-compose coordinates the network. The source are located in the `srcs/requirements` folder.

### Design

- Operating System: The host machine runs **Debian `12.12`.
- Base Images: The containers (NGINX, MariaDB, WordPress) are built from **Debian 12 (Bookworm), because of the versions stability.
- Security (TLS): We are using NGINX for reverse proxy and its the only entry point to the network, via port 44, via TLSv1.2/1.3.
- Persistence: The data is stored in docker volumes (`wp_data`, `db_data`), mounted at `/home/user/data` on the host. Bind mounts are strictly forbidden by the subject.

### Technical Comparisons

#### Virtual Machines vs Docker 

##### VM - Features:
- **Architecture**  Runs a full Guest OS on a Hypervisor
- **Performance**   High overhead (CPU /RAM) for OS operations 
- **Isolation**     Hardware-level isolation
- **Size**          Large (size of Gigabytes)

##### Docker - Features:
- **Architecture**  Shares the host OS kernel - isolates processes in user space
- **Performance**   Lightweight - near-native performance
- **Isolation**     Process-level isolation (namespaces & cgroups)
- **Size**          Small (size of Megabytes)


#### Secrets vs Environment Variables

##### VM - Environment Variables
- **Storage**       Stored as plain text in configuration or memory
- **Visibility**    Visible in `docker inspect` and `env` inside the container
- **Use Case**      Internal configuration (paths, username, ...)

##### Docker - Docker Secrets

- **Storage**       Stored encrypted on the disk (Swarm) or managed securly
- **Visibility**    Only mounted as files (e.g. `/run/secrets/my_secrets`) into the container
- **Use Case**      Sensitive data (passwords, certificates)


#### Docker Network vs Host Network

##### Host Network

- **Isolation**     Container shares the host's networking namesapce
- **Port Mapping**  No mapping needed - binds directly to host interface
- **Security**      Low - directly exposed to the outside world

##### Docker Network

- **Isolation**     Container gets its own IP and network namespace
- **Port Mapping**  Ports must be explicitly published (`-p 443:443`)
- **Security**      High - communication only allowed within the defined network; there is only one enrtypoint


#### Docker Volumes vs Bind Mounts

##### Docker Volumes

- **Management**    Managed by Docker (`/var/lib/dokcer/volumes`)
- **Portability**   High - independent of host directory structure
- **Subject Rule**  Mandatory for persistent database and web files.

##### Bind Mounts

- **Management**    Managed by user on host file system
- **Portability**   Low - relies on specific paths existing on the host
- **Subject Rule**  Forbidden for the main data storage in this project

## Resources


### AI Usage
- research about how to write docker and understand basic priciples of writing it
- used for gaps in understanding (e.g. when reading documentations, to get more simple explanations)
- for debugging - understanding and researching about errors that were unknown to me or hard to understand