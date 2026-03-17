# 03-Terraform-Azure

This project automates the deployment of an Azure Virtual Machine pre-configured with Docker. It includes self-bootstrapping script that automatically handles the creation of the Azure Storage Account and Resource Group required for the Terraform remote backend.

## Overview

Managing Terraform state in Azure typically requires creating a Storage Account before you can run your main infrastructure code.

1. **Bootstrap Phase:** A script checks if a backend exists. If not, it runs a bootstrap Terraform configuration.

2. **GitHub Integration:** The script saves the resulting Backend details (Resource Group, Storage Account) to GitHub Variables using the gh CLI.

3. **Main Phase:** It initializes the main infrastructure using those dynamic variables.

## Architecture

`/bootstrap:` Terraform code to create the Storage Account and Container for state files.

`/app:` Main Terraform code to deploy the Azure VM and install Docker.

`/app/init-backed.sh:`: The script that initialize remote backend.

# Prerequisites

Before running the script, ensure you have the following installed and authenticated:

- Azure CLI (`az`): `az login`
- GitHub CLI (`gh`): `gh auth login`
- Terraform: `terraform -v`
- Bash Environment: (Linux, macOS, or WSL2)
