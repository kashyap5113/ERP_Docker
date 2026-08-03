# SkyERP Docker Deployment

A production-ready Docker deployment for **ERPNext v16** with **HRMS** and **India Compliance**, featuring automatic site creation and application installation.

---

## Features

- ERPNext v16
- HRMS v16
- India Compliance v16
- Automatic site creation
- Automatic ERPNext installation
- Automatic HRMS installation
- Automatic India Compliance installation
- Automatic scheduler enablement
- Automatic database permission fix
- Docker Compose based deployment
- Single custom Docker image

---

## Project Structure

```
.
├── Dockerfile
├── startup.sh
├── compose.yaml
├── compose.skyerp.yaml
├── init/
│   └── init.sh
├── overrides/
│   ├── compose.mariadb.yaml
│   └── compose.redis.yaml
└── README.md
```

---

# Requirements

- Ubuntu 24.04 LTS
- Docker
- Docker Compose v2
- Git

---

# Installation

## 1. Clone Repository

```bash
git clone https://github.com/kashyap5113/ERP_Docker.git

cd ERP_Docker
```

---

## 2. Build Custom Image

```bash
docker build -t skyerp:v16 .
```

---

## 3. Start ERP

```bash
docker compose \
-f compose.yaml \
-f overrides/compose.mariadb.yaml \
-f overrides/compose.redis.yaml \
-f compose.skyerp.yaml \
up -d
```

---

## 4. Wait

The initialization container will automatically

- Create MariaDB database
- Create ERPNext site
- Install ERPNext
- Install HRMS
- Install India Compliance
- Configure database permissions
- Enable scheduler

No manual Bench commands are required.

---

## 5. Open Browser

```
http://SERVER_IP:8080
```

Example

```
http://192.168.0.126:8080
```

---

# Default Login

Username

```
Administrator
```

Password

```
admin
```

Change the Administrator password immediately after the first login.

---

# Installed Applications

- ERPNext
- HRMS
- India Compliance

---

# Verify Installation

Check installed apps

```bash
docker compose \
-f compose.yaml \
-f overrides/compose.mariadb.yaml \
-f overrides/compose.redis.yaml \
-f compose.skyerp.yaml \
exec backend \
bench --site skyerp.local list-apps
```

Expected output

```
frappe
erpnext
hrms
india_compliance
```

---

Check scheduler

```bash
docker compose \
-f compose.yaml \
-f overrides/compose.mariadb.yaml \
-f overrides/compose.redis.yaml \
-f compose.skyerp.yaml \
exec backend \
bench --site skyerp.local doctor
```

Expected

```
Workers online: 2
```

---

# Updating

After changing the Dockerfile

```bash
docker build -t skyerp:v16 .
```

Restart

```bash
docker compose \
-f compose.yaml \
-f overrides/compose.mariadb.yaml \
-f overrides/compose.redis.yaml \
-f compose.skyerp.yaml \
up -d
```

---

# Deployment Workflow

```
Clone Repository
        │
        ▼
Build Docker Image
        │
        ▼
Docker Compose Up
        │
        ▼
MariaDB + Redis Start
        │
        ▼
Init Container
        │
        ▼
Create Site
        │
        ▼
Install ERPNext
        │
        ▼
Install HRMS
        │
        ▼
Install India Compliance
        │
        ▼
Enable Scheduler
        │
        ▼
Ready to Use
```

---

# Customization

The initialization script is located at

```
init/init.sh
```

The Docker image is defined in

```
Dockerfile
```

Docker overrides are located in

```
compose.skyerp.yaml
```

---

# License

This project is based on the official ERPNext Docker project by Frappe Technologies and contains custom automation for application installation and deployment.

Official Project

https://github.com/frappe/frappe_docker

---

# Author

**Kashyap Parmar**

Python Developer

ERPNext & Frappe Developer

GitHub

https://github.com/kashyap5113
