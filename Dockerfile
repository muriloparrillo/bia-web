# Etapa 1: imagem base com PHP
FROM php:8.3-cli

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    unzip zip curl git \
    libonig-dev libzip-dev \
    mariadb-client libsqlite3-dev libcurl4-openssl-dev \
    gnupg wget

# Instala extensões do PHP necessárias para Laravel
RUN docker-php-ext-install pdo pdo_mysql mbstring zip

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instala o Node.js 18.x e npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia o conteúdo do projeto para dentro do container
COPY . .

# Instala dependências do Laravel
RUN composer install --no-interaction --optimize-autoloader

# Ajusta permissões dos diretórios necessários
RUN mkdir -p storage/logs bootstrap/cache && \
    chown -R www-data:www-data storage bootstrap/cache

# Expõe a porta que o Laravel vai usar
EXPOSE 80

# Comando que roda a aplicação
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]
