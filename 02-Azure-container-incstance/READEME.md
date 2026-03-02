# Azure Container Instance deployment

This script automates the Azure OIDC (OpenID Connect) setup by synchronizing your **GitHub CLI (gh)** and **Azure CLI (az)** configurations. It dynamically retrieves your repository metadata and subscription details to establish a secure, secret-less handshake between GitHub Actions and Azure, eliminating manual copy-pasting and common "No subscriptions found" errors.

### Prerequisites

- You must be logged into the **Azure CLI (az login)**.
- You must be logged into the **GitHub CLI (gh auth login)**.
- You must be inside the local directory of your Git repository.

```bash
bash setup-azure-oidc.sh
```
