#!/bin/bash
set -e

SITE_NAME=${SITE_NAME:-skyerp.local}
DB_ROOT_USER=${DB_ROOT_USER:-root}
DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD:-123}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}

cd /home/frappe/frappe-bench

echo "Starting SkyERP..."

if [ ! -d "sites/$SITE_NAME" ]; then
    echo "Creating site..."

    bench new-site "$SITE_NAME" \
        --db-root-username "$DB_ROOT_USER" \
        --db-root-password "$DB_ROOT_PASSWORD" \
        --admin-password "$ADMIN_PASSWORD"

    bench --site "$SITE_NAME" install-app erpnext
    bench --site "$SITE_NAME" install-app hrms
    bench --site "$SITE_NAME" install-app india_compliance

    bench --site "$SITE_NAME" enable-scheduler
fi

exec /usr/local/bin/nginx-entrypoint.sh "$@"
