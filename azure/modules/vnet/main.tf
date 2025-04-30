# Resource Group
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "iovision-rg"
}

# Virtual Network
resource "azurerm_virtual_network" "iovision_network" {
  name                = "iovision-vnet"
  address_space       =var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# iovision_public_subnet 
resource "azurerm_subnet" "iovision_public_subnet" {
  name                 = "iovision_public_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.iovision_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

# iovision_private_subnet
resource "azurerm_subnet" "iovision_private_subnet" {
  name                 = "subnet-2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.iovision_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

