resource "azurerm_resource_group" "arc_cluster_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_kubernetes_cluster" "arc_cluster" {
  name                      = format("%s-aks", replace(var.resource_group_name, "-rg", ""))
  location                  = azurerm_resource_group.arc_cluster_rg.location
  resource_group_name       = azurerm_resource_group.arc_cluster_rg.name
  dns_prefix                = replace(var.resource_group_name, "-rg", "")
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name                        = replace(format("%s", replace(var.resource_group_name, "-rg", "")), "-", "")
    temporary_name_for_rotation = replace(format("%stmp", replace(var.resource_group_name, "-rg", "")), "-", "")
    max_count                   = var.default_node_pool_node_count
    min_count                   = "1"
    enable_auto_scaling         = true
    vm_size                     = var.default_node_pool_vm_size
    os_disk_size_gb             = var.os_disk_size
    type                        = "VirtualMachineScaleSets"

    upgrade_settings {
      max_surge = "10%"
    }
  }

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.azure.id]
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      default_node_pool[0].min_count, tags
    ]
  }
}


