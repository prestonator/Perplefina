#!/bin/bash
set -e

# Run database migrations
echo "Running database migrations..."
node /home/perplexica/migrate.js

# Set default PORT if not provided by Railway
export PORT=${PORT:-3000}

echo "Starting services..."
echo "SearXNG will be available internally at http://127.0.0.1:8080"
echo "Perplexica will be available at port $PORT"

# Start supervisord (manages both processes)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf