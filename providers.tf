
provider "azurerm" {
  features {}
  client_id       = var.spoke_client_id
  client_secret   = var.spoke_client_secret
  tenant_id       = local.tenant-id
  subscription_id = var.spoke_sub_id
}

provider "azurerm" {
  alias = "spoke"

  client_id       = var.spoke_client_id
  client_secret   = var.spoke_client_secret
  tenant_id       = local.tenant-id
  subscription_id = var.spoke_sub_id

  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

// The provider that can access the VM images
provider "azurerm" {
  alias = "vm_images"

  client_id       = var.spoke_client_id
  client_secret   = var.spoke_client_secret
  tenant_id       = local.tenant-id
  subscription_id = var.image_sub_id

  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

// The provider that can access the storage account to store diagnostics
provider "azurerm" {
  alias = "storage_account"

  client_id       = var.spoke_client_id
  client_secret   = var.spoke_client_secret
  tenant_id       = local.tenant-id
  subscription_id = "c0c8209e-5456-409b-9615-693a24c44079"

  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

// The provider that can acccess a separate Key Vault
provider "azurerm" {
  alias = "key_vault"

  client_id       = var.spoke_client_id
  client_secret   = var.spoke_client_secret
  tenant_id       = local.tenant-id
  subscription_id = var.key_vault_sub_id
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
