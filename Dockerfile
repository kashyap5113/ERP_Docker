FROM frappe/erpnext:v16.30.0

USER root

RUN apt-get update && apt-get install -y git

USER frappe

WORKDIR /home/frappe/frappe-bench

RUN bench get-app hrms --branch version-16 https://github.com/frappe/hrms.git

RUN bench get-app india_compliance --branch version-16 https://github.com/resilient-tech/india-compliance.git



