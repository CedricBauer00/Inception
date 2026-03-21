# DEVELOPER Documentation

This stack provides the following services: WordPress (website and admin panel), MariaDB (database), Nginx (web server), Adminer (database administration), Reds (caching), FTP server (file transfer) and Rsync (backups).

To start the project, simply run 'make' in the project root directory. To stop and remove all containers, volumes, and the data, run 'make fclean'.

You can access the website at 'http://localhost' and the WordPress admin panel at 'http://localhost/wp=admin' in your browser.

All credentials (WordPress, MariaDB, FTP, etc.) are stored ad files in './srcs/secrets/'.

To check if services are running, use 'docker ps'.
To view logs for a specific service, use 'docker logs -f <service=name>'.
To enter a running container for troubleshooting, use 'docker exec -it <>service-name> bash'.

Persistent data for WOrdPress, MariaDB, and backups is stored in Docker volumes, mapped ot the 'data' folder on the host. This ensures that chagnes to the website or database are mot lost when containers are stopped or removed.
