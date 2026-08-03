#!/bin/bash
set -e

SITE_NAME=${SITE_NAME:-skyerp.local}

cd /home/frappe/frappe-bench

echo "Checking if site exists..."

if [ ! -d "sites/$SITE_NAME" ]; then
    echo "Creating site..."

    bench new-site "$SITE_NAME" \
        --db-root-username root \
        --db-root-password 123 \
        --admin-password admin
    bench --site "$SITE_NAME" install-app erpnext
    bench --site "$SITE_NAME" install-app hrms
    bench --site "$SITE_NAME" install-app india_compliance

    DB_NAME=$(jq -r '.db_name' sites/$SITE_NAME/site_config.json)
    DB_USER=$(jq -r '.db_user' sites/$SITE_NAME/site_config.json)
    DB_PASS=$(jq -r '.db_password' sites/$SITE_NAME/site_config.json)
mysql -h db -uroot -p123 <<EOF
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

    bench --site "$SITE_NAME" enable-scheduler

    echo "Site Created Successfully"
else
    echo "Site already exists"
fi
