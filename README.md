# Full-Stack FastAPI and React Template

Welcome to the Full-Stack FastAPI and React template repository. This repository serves as a demo application for interns, showcasing how to set up and run a full-stack application with a FastAPI backend and a ReactJS frontend using ChakraUI.

## Project Structure

The repository is organized into two main directories:

- **frontend**: Contains the ReactJS application.
- **backend**: Contains the FastAPI application and PostgreSQL database integration.

Each directory has its own README file with detailed instructions specific to that part of the application.

## Getting Started

To get started with this template, please follow the instructions in the respective directories:

- [Frontend README](./frontend/README.md)
- [Backend README](./backend/README.md)

This repository contains a full-stack application setup using Docker Compose. The application consists of a FastAPI backend, a Node.js frontend, a PostgreSQL database, an Adminer database management tool, an Nginx Proxy Manager, and an Nginx web server.

### This repository is configured to be able to deploy locally (development) and in production.

- **backend**: FastAPI application serving the backend API.
- **frontend**: Node.js application serving the frontend.
- **db**: PostgreSQL database for storing application data.
- **adminer**: Database management tool to interact with the PostgreSQL database.
- **proxy**: Nginx Proxy Manager to handle SSL certificates and domain management.
- **nginx**: Nginx web server to serve the frontend and reverse proxy requests to the backend.

## How to set up locally

1. **Clone the repository**:

   ```sh
   git clone https://github.com/DrInTech22/devops-stage-2.git
   cd devops-stage-2
   ```

2. **Build and start the services**:

   ```sh
   docker compose -f docker-compose.yml -f docker-compose.dev.yml up
   ```
   for older version of docker compose, run:
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
   ```   

3. **Verify the services are running and all path are accessible**:
   - **FastAPI Backend**: [http://localhost/api](http://localhost/api)
   - **FastAPI Backend Docs**: [http://localhost/docs](http://localhost/docs)
   - **FastAPI Backend Redoc**: [http://localhost/api/redoc](http://localhost/api)
   - **Node.js Frontend**: [http://localhost](http://localhost)
   - **PostgreSQL Database**: internally ccessible on port `5432` (no direct browser access)
   - **Adminer**: [http://localhost:8080](http://localhost:8080) or [http://db.localhost](http://db.localhost)
   - **Nginx Proxy Manager**: [http://localhost:8090](http://localhost:8090) or [http://proxy.localhost](http://proxy.localhost)


## Local Service Details (docker-compose.dev.yml)

### Backend (FastAPI)

- **Directory**: `./backend`
- **Dockerfile for development**: `Dockerfile.dev`
- **Port**: `8000`
- **Development Environment Variables file**: `backend/.env.dev`
  
### Frontend (Node.js)

- **Directory**: `./frontend`
- **Dockerfile for development**: `Dockerfile.dev`
- **Port**: `5173`
- **Development Environment Variables file**: `frontend/.env.dev`

### Database (PostgreSQL)

- **Docker Image**: `postgres:13`
- **Port**: `5432`
- **Environment Variables**:
  - `POSTGRES_USER`: Username for PostgreSQL.
  - `POSTGRES_PASSWORD`: Password for the PostgreSQL user.
  - `POSTGRES_DB`: Name of the PostgreSQL database.
- **Volumes**:
  - `postgres_data`: Persists PostgreSQL data.

### Adminer

- **Docker Image**: `adminer`
- **Port**: `8080`

### Proxy (Nginx Proxy Manager)

- **Docker Image**: `jc21/nginx-proxy-manager:latest`
- **Docker Container**: `nginx_proxy_manager`
- **Port**: `8090`
- **Volumes**:
  - `./data`: Persistent data for the proxy manager.
  - `./letsencrypt`: SSL certificates.

### Nginx

- **Docker Image**: `nginx:latest`
- **Docker Container**: `nginx`
- **Port**: `80`
- **Volumes**:
  - `./nginx/nginx.dev.conf`: Configuration file for Nginx.
  - `./nginx/proxy_params.dev.conf`: Proxy parameters for Nginx.
- **Depends On**:
  - `frontend`
  - `backend`
  - `db`
  - `adminer`
  - `proxy`

## How to set up in production with domain
This section sets up the full stack application in production, configures domain name to access the application and secures it with ssl certificates.

### Set up domain
- Get a domain e.g mydomain.com, configure the following subdomain as A records pointing to your public ip.
- **mydomain.com, db.mydomain.com, proxy.mydomain.com**
- replace the subdomain in nginx/nginx.conf with your subdomain in all required lines.
- This example used **drintech.cloudopsdomain.online, db.drintech.cloudopsdomain.online, proxy.drintech.cloudopsdomain.online**

## the initial setup of application 
- clone the application
  ```sh
   git clone https://github.com/DrInTech22/devops-stage-2.git
   cd devops-stage-2
   ```
- run the application
  ```sh
  docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
  ```
- access the NPM on your browser using your public-ip
  ```sh
   your_public_ip:8090
   ```
- login using NPM default login 
  ```
  username: admin@example.com
  password: changeme
  ```
  you will be prompted to change the password after login

- generate ssl certificates for your subdomains in the following order below using **lets encrypt**. We will use the sample domain.
  - **drintech.cloudopsdomain.online**
  - **db.drintech.cloudopsdomain.online**
  - **proxy.drintech.cloudopsdomain.online**
- stop the applications
  ```
  docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
  ```
- uncomment `#- ./nginx/nginx.prod.conf:/data/nginx/custom/http_top.conf` in the docker-compose.prod.yaml file. This maps nginx.prod.conf file on NPM.
- nginx.prod.conf sets up proxy host for the sub-domains, wwww to non-wwww redirection and http to https redirection.
- restart the application
  ```sh
  docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
  ```
- **Verify the services are running and all path are accessible**:
   - **FastAPI Backend**: drintech.cloudopsdomain.online/api
   - **FastAPI Backend Docs**: drintech.cloudopsdomain.online/docs
   - **FastAPI Backend Redoc**: drintech.cloudopsdomain.online/redoc
   - **Node.js Frontend**: drintech.cloudopsdomain.online
   - **Adminer**: db.drintech.cloudopsdomain.online
   - **Nginx Proxy Manager**: proxy.drintech.cloudopsdomain.online

- test http to https redirection and www to non-www redirection is working




