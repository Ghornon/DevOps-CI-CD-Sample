#!/bin/bash

# Check for dependencies
for cmd in az gh git; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is not installed. Please install it to continue."
    exit 1
  fi
done

RESOURCE_GROUP=$(gh variable get RESOURCE_GROUP 2>/dev/null || echo "")
STORAGE_ACCOUNT_NAME=$(gh variable get STORAGE_ACCOUNT_NAME 2>/dev/null || echo "")

echo "Checking for Azure Backend: $STORAGE_ACCOUNT_NAME in $RESOURCE_GROUP..."

# Check Azure for the Storage Account
if [[ -z "$RESOURCE_GROUP" || -z "$STORAGE_ACCOUNT_NAME" ]] || \
   ! az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RESOURCE_GROUP" &>/dev/null; then

    (
        cd ../bootstrap || exit 1
        terraform init
        terraform apply -auto-approve

        # Capture outputs properly
        RG_OUT=$(terraform output -raw azurerm_resource_group)
        SA_OUT=$(terraform output -raw azurerm_storage_account)

        # Update GitHub Variables
        gh variable set RESOURCE_GROUP --body "$RG_OUT"
        gh variable set STORAGE_ACCOUNT_NAME --body "$SA_OUT"
        
        # Update local script variables for the next step
        RESOURCE_GROUP="$RG_OUT"
        STORAGE_ACCOUNT_NAME="$SA_OUT"
    )
    
    # Re-sync variables if they were updated in the subshell
    RESOURCE_GROUP=$(gh variable get RESOURCE_GROUP 2>/dev/null)
    STORAGE_ACCOUNT_NAME=$(gh variable get STORAGE_ACCOUNT_NAME 2>/dev/null)
else
    echo "Backend already exists. Skipping bootstrap."
fi

# Now initialize the main infrastructure
echo "Initializing Application Infrastructure..."
terraform init \
  -backend-config="resource_group_name=$RESOURCE_GROUP" \
  -backend-config="storage_account_name=$STORAGE_ACCOUNT_NAME" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=prod.terraform.tfstate"

terraform import 