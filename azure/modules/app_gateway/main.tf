resource "azurerm_public_ip" "agw_pip" {
  name                = "iovison-agw-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "iovison_gateway" {
  name                = "iovison-agw"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "iovison-gateway-ip-config"
    subnet_id = var.frontend_subnet_id
  }

  frontend_port {
    name = "iovison-frontend-port"
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = "iovison-frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.agw_pip.id
  }

  backend_address_pool {
    name = "iovison-backend-pool"
  }

  backend_http_settings {
    name                  = "iovison-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = var.backend_port
    protocol              = "Http"
    request_timeout       = var.request_timeout
  }

  http_listener {
    name                           = "iovison-listener"
    frontend_ip_configuration_name = "iovison-frontend-ip-config"
    frontend_port_name             = "iovison-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "iovison-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "iovison-listener"
    backend_address_pool_name  = "iovison-backend-pool"
    backend_http_settings_name = "iovison-http-settings"
    priority                   = var.rule_priority
  }
}

resource "azurerm_network_interface" "backend_nic" {
  count               = var.backend_vm_count
  name                = "iovison-backend-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "iovison-nic-ipconfig-${count.index}"
    subnet_id                     = var.backend_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic_assoc" {
  count                   = var.backend_vm_count
  network_interface_id    = azurerm_network_interface.backend_nic[count.index].id
  ip_configuration_name   = "iovison-nic-ipconfig-${count.index}"
  backend_address_pool_id = one(azurerm_application_gateway.iovison_gateway.backend_address_pool).id
}

resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_windows_virtual_machine" "backend_vm" {
  count               = var.backend_vm_count
  name                = "iovison-backend-vm-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  admin_password      = random_password.vm_password.result

  network_interface_ids = [
    azurerm_network_interface.backend_nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.vm_image_sku
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "vm_extension" {
  count                = var.backend_vm_count
  name                 = "iovision-vm-extension-${count.index}"
  virtual_machine_id   = azurerm_windows_virtual_machine.backend_vm[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"
    }
SETTINGS
}