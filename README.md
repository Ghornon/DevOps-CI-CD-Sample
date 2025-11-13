# DevOps CI/CD Sample

A complete **Infrastructure-as-Code** setup that creates and runs three Docker containers:

-   📦 **Database**: SQL Server 2022
-   🖥️ **Server**: ASP.NET Core API
-   🎨 **Client**: React/Vite Frontend

## Overview

This demo showcases the integration of **GitHub Actions**, **Docker**, and **Terraform**.

You can run the application using either Docker Compose or Terraform:

-   The **Docker Compose** file is located in the root folder.
-   **All Terraform configurations** are organized under the `./terraform` directory.

> ⚠️ Note: The Terraform setup is intentionally overengineered to demonstrate its capabilities, even though the example itself is quite basic.

---

## Requirements

-   Terraform
-   Docker & Docker Compose
-   Bash/Shell

## Docker compose

### 1. Setup .env file

```bash
echo "DB_PASSWORD=S3cur3P@ssW0rd" >> .env
```

### 2. Run docker compose

```bash
docker compose up
```

## Terraform

### 1. Enter Terraform Directory

```bash
cd terraform
```

### 2. Create terraform.tfvars file and include example variables

```bash
db_password = "DevPassword123!"
environment = "Development"

server_container_name = "ebilety-server-dev"
client_container_name = "ebilety-client-dev"
db_container_name     = "ebilety-db-dev"

server_image_name = "ebilety-server:dev"
client_image_name = "ebilety-client:dev"
```

### 2. Initialize (First time only)

```bash
terraform init
```

### 3. Deploy Everything

```bash
terraform apply
```

Terraform will show what it's about to create. Type `yes` to confirm.

## View Your Deployment

```bash
# Show all URLs and container info
terraform output

# View specific URL
terraform output client_url
terraform output server_url
```

## Common Commands

| Command              | Purpose                |
| -------------------- | ---------------------- |
| `terraform plan`     | Preview changes        |
| `terraform apply`    | Deploy containers      |
| `terraform destroy`  | Remove containers      |
| `terraform output`   | Show deployment info   |
| `terraform validate` | Validate configuration |

## Docker vs Terraform

Both approaches deploy identical infrastructure:

| Task                 | Docker Compose        | Terraform           |
| -------------------- | --------------------- | ------------------- |
| Start all containers | `docker-compose up`   | `terraform apply`   |
| Stop all containers  | `docker-compose down` | `terraform destroy` |
| View status          | `docker-compose ps`   | `terraform output`  |
| Environment config   | `.env`                | `terraform.tfvars`  |

### Modules

-   `modules/network/` - Creates Docker network
-   `modules/images/` - Builds Docker images from Dockerfiles
-   `modules/containers/` - Manages running containers

## Advanced Usage

### Use Production Environment

```bash
terraform apply -var-file="prod.tfvars"
```

### Custom Variables

```bash
terraform apply \
  \
  -var="db_password=MyCustomPassword123!" \
  -var="server_port_http=9000"
```

### View State

```bash
terraform show
```

### Rebuild Images

```bash
terraform taint module.images.docker_image.server
terraform taint module.images.docker_image.client
terraform apply
```

## Troubleshooting

### Port Already in Use?

```bash
terraform apply \
  \
  -var="server_port_http=9000" \
  -var="client_port=8081"
```

### Check Container Logs

```bash
docker logs ebilety-db
docker logs ebilety-server
docker logs ebilety-client
```

### Remove Everything and Start Fresh

```bash
terraform destroy
rm -rf .terraform* tfplan
terraform init
terraform apply
```
