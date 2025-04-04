#!/bin/sh
set -e

apk update
apk add mysql-client

echo "testing connection db..."
mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" -e "SELECT 1;"

host=${DB_HOST:-mysql}
user=${DB_USERNAME:-voting}
password=${DB_PASSWORD:-voting}

echo "⏳ Waiting for MySQL at $host with user $user..."


for i in $(seq 1 30); do
  if mysql -h "$host" -u "$user" -p"$password" -e "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ MySQL is ready!"
    break
  fi
  echo "🔁 Attempt $i: still waiting..."
  sleep 2
done

echo "🏗 Running migrations..."
php artisan migrate --force

echo "🚀 Starting PHP-FPM..."
exec php-fpm
