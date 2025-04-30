provider "azurerm" {
  features {}
}

module "vnet" {
  source                     = "./modules/vnet"
  resource_group_location    = "eastus"
  resource_group_name_prefix = "myapp"
  location = var.location
  resource_group_name = var.resource_group_name
  vnet_name = var.vnet_name

}

module "application_gateway" {
  source              = "./modules/app_gateway"
  prefix              = "iovision"
  resource_group_name = module.vnet.resource_group_name
  location            = module.vnet.location
  frontend_subnet_id  = module.vnet.public_subnet_id
  backend_subnet_id   = module.vnet.private_subnet_id

}


module "iovision_app" {
  source = "./modules/container"

  location            = "eastus"
  resource_group_name = "my-resource-group"
  app_name            = "myapp"

  # PostgreSQL configuration
  postgres_user     = "admin"
  postgres_password = "P@ssw0rd123!"
  postgres_db       = "appdb"

  # pgAdmin configuration
  pgadmin_email    = "admin@example.com"
  pgadmin_password = "P@ssw0rd123!"

  # Application images
  backend_image  = "wajdi1999/back-end-app:latest"
  frontend_image = "wajdi1999/frontend-app:latest"

  # Storage configuration
  storage_account_name = "mystorageaccount"
  storage_share_name   = "myshare"
  storage_account_key  = "storage-account-key"

  tags = {
    Environment = "Production"
  }
}




