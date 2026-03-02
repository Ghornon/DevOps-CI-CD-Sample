# Azure container instance deployment

Source: https://learn.microsoft.com/en-us/azure/container-instances/container-instances-github-action

## Configure GitHub workflow

### Create resource group

```powershell
az group create --name sample-rg --location westeurope
```

### Create credentials for Azure authentication

```PowerShell
New-AzADServicePrincipal -DisplayName "GitHubActionsConnection"
$ServicePrincipalName = "GitHubActionsConnection"
$AzSubscriptionName = "Default"

Connect-AzureAD

$Subscription = (Get-AzSubscription -SubscriptionName $AzSubscriptionName)
$ServicePrincipal = Get-AzADServicePrincipal -DisplayName $ServicePrincipalName
$AzureADApplication = Get-AzureADApplication -SearchString $ServicePrincipalName

$OutputObject = [PSCustomObject]@{
clientId = $ServicePrincipal.AppId
clientSecret = (New-AzureADApplicationPasswordCredential -ObjectId $AzureADApplication.ObjectId).Value
subscriptionId = $Subscription.Id
tenantId = $Subscription.TenantId
}

$OutputObject | ConvertTo-Json
```

Output is similar to:

```JSON
{
  "clientId": "xxxx6ddc-xxxx-xxxx-xxx-ef78a99dxxxx",
  "clientSecret": "xxxx79dc-xxxx-xxxx-xxxx-aaaaaec5xxxx",
  "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
  "tenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
}
```

Save it as github secret `AZURE_CREDENTIALS={JSON}`
