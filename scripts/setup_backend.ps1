# setup_backend.ps1
# This script creates the Azure resources required for the Terraform backend.
# Run this once before running Terraform Init in the environments/dev directory.

$RESOURCE_GROUP_NAME = "rg-terraform-state"
$LOCATION = "East US" # Change this to your preferred location
$STORAGE_ACCOUNT_NAME = "sttfstate1400560" # MUST BE GLOBALLY UNIQUE
$CONTAINER_NAME = "tfstate"

# 1. Create Resource Group
Write-Host "Creating Resource Group: $RESOURCE_GROUP_NAME..." -ForegroundColor Cyan
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# 2. Create Storage Account
Write-Host "Creating Storage Account: $STORAGE_ACCOUNT_NAME..." -ForegroundColor Cyan
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --location $LOCATION --sku Standard_LRS --allow-blob-public-access false

# 3. Create Storage Container
Write-Host "Creating Storage Container: $CONTAINER_NAME..." -ForegroundColor Cyan
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

Write-Host "Backend resources created successfully!" -ForegroundColor Green
Write-Host "Ensure that '$STORAGE_ACCOUNT_NAME' matches the 'storage_account_name' in your backend.tf file." -ForegroundColor Yellow
