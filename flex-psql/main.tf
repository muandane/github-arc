resource "azurerm_resource_group" "psql" {
  name     = "psql-rg"
  location = var.location
}

resource "azurerm_virtual_network" "psql" {
  name                = "psql-vn"
  location            = azurerm_resource_group.psql.location
  resource_group_name = azurerm_resource_group.psql.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "psql" {
  name                 = "psql-sn"
  resource_group_name  = azurerm_resource_group.psql.name
  virtual_network_name = azurerm_virtual_network.psql.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
resource "azurerm_private_dns_zone" "psql" {
  name                = "psql-flex.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.psql.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "psql" {
  name                  = "psqlVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.psql.name
  virtual_network_id    = azurerm_virtual_network.psql.id
  resource_group_name   = azurerm_resource_group.psql.name
  depends_on            = [azurerm_subnet.psql]
}

resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = "psql-psqlflexibleserver"
  resource_group_name    = azurerm_resource_group.psql.name
  location               = azurerm_resource_group.psql.location
  version                = "12"
  delegated_subnet_id    = azurerm_subnet.psql.id
  private_dns_zone_id    = azurerm_private_dns_zone.psql.id
  administrator_login    = var.admin-username
  administrator_password = var.admin-password
  zone                   = "1"

  storage_mb   = 32768
  storage_tier = "P30"

  sku_name   = var.sku_name
  depends_on = [azurerm_private_dns_zone_virtual_network_link.psql]

}
