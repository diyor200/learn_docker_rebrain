#!/bin/sh
set -e

apk update
apk add mysql-client

echo "testing connection db..."
mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" -e "SELECT 1;"

echo "⏳ Waiting for MySQL at $DB_HOST..."
until mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
  echo "🔁 Waiting for MySQL..."
  sleep 2
done

echo "✅ MySQL is ready. Running Laravel setup..."

php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan config:cache
php artisan migrate --force

echo "🚀 Starting PHP-FPM..."
exec php-fpm
