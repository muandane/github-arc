terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.40.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.13.1"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
provider "random" {}
provider "azuread" {}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.arc_cluster.kube_config[0].host
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.arc_cluster.kube_config[0].cluster_ca_certificate)
    client_certificate     = base64decode(azurerm_kubernetes_cluster.arc_cluster.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.arc_cluster.kube_config[0].client_key)
  }
}
