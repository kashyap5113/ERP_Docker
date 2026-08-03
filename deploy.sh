#!/bin/bash
set -e

echo "========================================"
echo "       SkyERP Docker Deployment"
echo "========================================"

# Create .env automatically if missing
if [ ! -f .env ]; then
    echo "Creating .env from example.env..."
    cp example.env .env
fi

echo
echo "Starting Docker containers..."

docker compose \
-f compose.yaml \
-f overrides/compose.mariadb.yaml \
-f overrides/compose.redis.yaml \
-f compose.skyerp.yaml \
up -d --build

echo
echo "========================================"
echo "Installing ERP..."
echo "This may take 3-8 minutes."
echo "========================================"

docker compose \
-f compose.yaml \
-f overrides/compose.mariadb.yaml \
-f overrides/compose.redis.yaml \
-f compose.skyerp.yaml \
logs -f init
