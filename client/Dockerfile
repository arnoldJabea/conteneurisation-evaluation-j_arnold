FROM php:8.2-apache-bullseye

# Installer le support MySQL (PDO)
RUN apt-get update && apt-get install -y \
    libmariadb-dev \
    && docker-php-ext-install pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copier les fichiers PHP vers le dossier exposé par Apache
COPY src/ /var/www/html/
