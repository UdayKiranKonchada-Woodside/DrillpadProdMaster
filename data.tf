data "azurerm_key_vault_secret" "domain_user_secret" {
  key_vault_id = var.ops_key_vault_id
  name         = var.dc_password_key_vault_name
  provider     = azurerm.key_vault
}

data "azurerm_key_vault_secret" "domain_user_name" {
  key_vault_id = var.ops_key_vault_id
  name         = var.dc_username_key_vault_name
  provider     = azurerm.key_vault
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  key_vault_id = var.ops_key_vault_id
  name         = var.admin_password_key_vault_name
  provider     = azurerm.key_vault
}

data "azurerm_key_vault_secret" "datadog_api_key" {
  key_vault_id = var.ops_key_vault_id
  name         = "datadog-api-key"
  provider     = azurerm.key_vault
}

data azurerm_storage_account "diagnostics" {
  for_each = (var.exclude_diagnostics == true) ? {} : var.vm_list
  name                = each.value.storage_account_name
  resource_group_name = each.value.storage_account_rg

  provider = azurerm.storage_account
}

data azurerm_shared_image "bhp_image" {
  gallery_name        = var.bhp_image_reference.gallery_name
  name                = var.bhp_image_reference.name
  resource_group_name = var.bhp_image_reference.resource_group_name

  provider = azurerm.vm_images
}

data "azurerm_key_vault_secret" "gitlab_scom_token" {
  key_vault_id = var.ops_key_vault_id
  name         = "SCOM-Git-Trigger-Token"
  provider     = azurerm.key_vault
}
