resource "azurerm_mssql_server" "this" {
  name                         = var.sql_server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name        = var.sql_database_name
  server_id   = azurerm_mssql_server.this.id  # Referencing the server_id

  tags = var.tags
}

