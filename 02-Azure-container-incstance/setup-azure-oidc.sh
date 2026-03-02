#!/bin/bash

################################################################################
# Script: setup-azure-oidc.sh
# Description: Automates the OIDC handshake between GitHub and Azure.
# Requirements: Azure CLI (az), GitHub CLI (gh), and a local git repo.
################################################################################

# Check for dependencies
for cmd in az gh git; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is not installed. Please install it to continue."
    exit 1
  fi
done

# 1. Automatically detect GitHub info from the current local repo
REPO_FULL_NAME=$(gh repo view --json nameWithOwner -q ".nameWithOwner")
GH_ORG=$(echo $REPO_FULL_NAME | cut -d'/' -f1)
GH_REPO=$(echo $REPO_FULL_NAME | cut -d'/' -f2)
BRANCH=$(git branch --show-current)

# 2. Automatically detect Azure info
TENANT_ID=$(az account show --query tenantId -o tsv)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# 3. Define the Service Principal Name
APP_NAME="gh-actions-${GH_REPO}"

echo "--------------------------------------------------------"
echo "Detected Repo: $REPO_FULL_NAME (Branch: $BRANCH)"
echo "Detected Subscription: $SUBSCRIPTION_ID"
echo "--------------------------------------------------------"

# 4. Create or Get the Service Principal
echo "Searching for Service Principal: $APP_NAME..."
CLIENT_ID=$(az ad app list --display-name "$APP_NAME" --query "[0].appId" -o tsv)

if [ -z "$CLIENT_ID" ]; then
    echo "Creating new Service Principal..."
    CLIENT_ID=$(az ad sp create-for-rbac --name "$APP_NAME" --role "Contributor" --scopes "/subscriptions/$SUBSCRIPTION_ID" --query "appId" -o tsv)
else
    echo "Existing Service Principal found. Ensuring Contributor role is assigned..."
    OBJECT_ID=$(az ad sp show --id "$CLIENT_ID" --query "id" -o tsv)
    az role assignment create --assignee "$OBJECT_ID" --role "Contributor" --scope "/subscriptions/$SUBSCRIPTION_ID" 2>/dev/null
fi

# 5. Create Federated Credential (OIDC)
echo "Creating Federated Identity for GitHub..."
az ad app federation-credential create --id "$CLIENT_ID" --parameters "{
  \"name\": \"github-oidc-$BRANCH\",
  \"issuer\": \"https://token.actions.githubusercontent.com\",
  \"subject\": \"repo:$REPO_FULL_NAME:ref:refs/heads/$BRANCH\",
  \"description\": \"OIDC for GitHub Actions\",
  \"audiences\": [\"api://AzureADTokenExchange\"]
}"

# 6. Push Secrets directly to GitHub
echo "Pushing secrets to GitHub repository..."
gh secret set AZURE_CLIENT_ID --body "$CLIENT_ID"
gh secret set AZURE_TENANT_ID --body "$TENANT_ID"
gh secret set AZURE_SUBSCRIPTION_ID --body "$SUBSCRIPTION_ID"

# 7. Push Secrets to .secrets file (optional, for local development)
echo "Saving secrets to .secrets file..."
cat <<EOF > .secrets
AZURE_CLIENT_ID=$CLIENT_ID
AZURE_TENANT_ID=$TENANT_ID
AZURE_SUBSCRIPTION_ID=$SUBSCRIPTION_ID
EOF

echo "--------------------------------------------------------"
echo "SUCCESS! Your GitHub Secrets are set and OIDC is linked."
echo "--------------------------------------------------------"