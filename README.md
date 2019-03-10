# Kubernetes, NGINX, PHP-FPM & MariaDB (KNPM)

This is a Docker image designed for PHP applications living in Kubernetes clusters, but can be used for anything. It says it's for MariaDB but it already supports Postgres and SQLite. In fact, many PHP extensions are already enabled in this image. The name of this image is just a "joke" with the old term LAMP (Linux, Apache, MySQL & PHP).

It starts with Alpine Linux as the base image, installs NGINX, PHP-FPM and lots of PHP extensions. Then it configures everything together. Mind that both the NGINX and PHP-FPM services are running in the same container (only NGINX is exposed). Some people may find this not ideal, but in my case it was.

It also uses `America/Sao_Paulo` as the system and PHP default timezone, you may want to change that.

## Usage

Just place your application files inside `/htdocs` and you should be good.
