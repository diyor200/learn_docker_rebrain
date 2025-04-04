FROM composer:1.9 AS composer

WORKDIR /app

RUN docker-php-ext-install pdo pdo_mysql \
 && mkdir -p /usr/src/php/ext/redis \
 && curl -L https://github.com/phpredis/phpredis/archive/5.0.0.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
 && echo 'redis' >> /usr/src/php-available-exts \
 && docker-php-ext-install redis

COPY . .
RUN composer install --prefer-dist --no-scripts --no-progress --optimize-autoloader

# --------------------------------------------------------

FROM php:7.3.3-fpm-alpine AS phpfpm

RUN apk add --no-cache bash libpng libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libzip-dev \
 && docker-php-ext-install pdo pdo_mysql zip

# Redis extension
RUN mkdir -p /usr/src/php/ext/redis \
 && curl -L https://github.com/phpredis/phpredis/archive/5.0.0.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
 && echo 'redis' >> /usr/src/php-available-exts \
 && docker-php-ext-install redis

# 👇 Now copy Laravel project
COPY --from=composer /app /var/www/html
WORKDIR /var/www/html

RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
 && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache \
 && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# 👇 Now set permissions and clear/cache Laravel
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache \
 && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]

