resource "azurerm_user_assigned_identity" "aks_uaidentity" {
  location            = var.location
  name                = "karpentermsi"
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_kubernetes_cluster.kp_cluster]
}

resource "azurerm_federated_identity_credential" "aks_federated_identity" {
  audience            = ["api://AzureADTokenExchange"]
  depends_on          = [azurerm_user_assigned_identity.aks_uaidentity]
  issuer              = azurerm_kubernetes_cluster.kp_cluster.oidc_issuer_url
  name                = "karpentermsi"
  parent_id           = azurerm_user_assigned_identity.aks_uaidentity.id
  resource_group_name = var.resource_group_name
  subject             = "system:serviceaccount:kube-system:karpenter-sa"
}

resource "azurerm_role_assignment" "karpenter_role_vmc" {
  depends_on           = [azurerm_federated_identity_credential.aks_federated_identity]
  principal_id         = azurerm_user_assigned_identity.aks_uaidentity.principal_id
  scope                = azurerm_kubernetes_cluster.kp_cluster.node_resource_group_id
  role_definition_name = "Virtual Machine Contributor"
}
resource "azurerm_role_assignment" "karpenter_role_ntwc" {
  depends_on           = [azurerm_federated_identity_credential.aks_federated_identity]
  principal_id         = azurerm_user_assigned_identity.aks_uaidentity.principal_id
  scope                = azurerm_kubernetes_cluster.kp_cluster.node_resource_group_id
  role_definition_name = "Network Contributor"
}
resource "azurerm_role_assignment" "karpenter_role_miop" {
  depends_on           = [azurerm_federated_identity_credential.aks_federated_identity]
  principal_id         = azurerm_user_assigned_identity.aks_uaidentity.principal_id
  scope                = azurerm_kubernetes_cluster.kp_cluster.node_resource_group_id
  role_definition_name = "Managed Identity Operator"
}
