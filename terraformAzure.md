# Terraform Azure

## Get Azure Subscription ID

```bash
az account show --query id -o tsv
```

## Create a Service Principal (for pipeline)

```bash
az ad sp create-for-rbac --name "ebilety-terraform-github-actions" \
  --role contributor \
  --scopes /subscriptions/$(az account show --query id -o tsv) \
  --json-auth
```

## After running the above command it will generate a json output as shown below

```JSON
{
  "clientId": "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "clientSecret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "subscriptionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenantId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

## Create ARM_CLIENT_ID,ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID as GitHub secrets in GitHub Repo as shown in the image below. Provide values for ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID from above JSON output

```bash
gh secret set AZURE_CLIENT_ID --body "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
gh secret set AZURE_TENANT_ID --body "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
gh secret set AZURE_SUBSCRIPTION_ID --body "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz"
gh secret set AZURE_CLIENT_SECRET --body "super-secret-password"
```
