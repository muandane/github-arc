data "azuread_client_config" "current" {}
data "azurerm_client_config" "current" {}

data "azurerm_user_assigned_identity" "azure" {
  name                = var.managed_identity_name
  resource_group_name = var.managed_identity_rg
}
