# DevOps CI/CD Sample

This project is a comprehensive DevOps CI/CD demonstration. It showcases a modern full-stack application lifecycle, spanning from local development to automated cloud deployment using industry-standard methodologies.

## Application Stack

### Client

A lightweight web application built with React, Vite, and Bun. The frontend communicates with the API server to retrieve data from the following endpoints:

- /api
- /api/db

![Client](/readme-assets/Client.png)

### Server

A high-performance backend built with JavaScript using the Bun runtime. It connects to a PostgreSQL database to perform health checks and retrieve system timestamps.
Available endpoints:

- / or /api (Base status)
- /api/db (Database connectivity test)
- /api/ping (Liveness probe)

---

## Deployment and Infrastructure

The repository is organized into progressive stages of automation:

### 01-Docker

- Provides a docker-compose.yml for local development and environment orchestration.
- Includes a GitHub Actions workflow (01-Docker-build-and-publish.yml) to automate the build process and publish images to the GitHub Container Registry (GHCR).

### 02-Azure-container-apps

- Currently broken.
- Intended for deploying built containers directly to Azure Container Instances (ACI).

### 03-Terraform-Azure

- Automates the creation of an Azure Virtual Machine and its surrounding infrastructure (VNET, Subnets, Security Groups).
- Includes Terraform backend configuration files and a script to handle the initial setup of the backend storage if it does not exist.

### 04-Ansible-Provisioning

- Handles configuration management for the Azure VM.
- Automates the installation of Docker and the deployment of application containers onto the provisioned host.
