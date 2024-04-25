terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.40.0"
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
