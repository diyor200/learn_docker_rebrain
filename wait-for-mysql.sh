#!/bin/sh
set -e

host="$DB_HOST"
user="$DB_USERNAME"
password="$DB_PASSWORD"

echo "⏳ Waiting for MySQL at $host..."
until mysql -h "$host" -u "$user" -p"$password" -e "SELECT 1;" > /dev/null 2>&1; do
  sleep 3
done

echo "✅ MySQL is ready! Running: $@"
exec "$@"
