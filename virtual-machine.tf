module "virtual_machine" {
  for_each = var.vm_list
  source = "git@gitlab.com:bhp-cloudfactory/azure-components/terraform-azurerm-vm-windows.git?ref=v0.8.8" #never use master always use a TAG!!!

  create_vm_resource_group         = each.value.create_vm_resource_group
  base_name                        = each.value.base_name
  name                             = each.value.name
  computer_name                    = each.value.computer_name
  computer_description             = each.value.computer_description
  resource_group_name              = each.value.resource_group_name
  location                         = each.value.location
  subnet_name                      = each.value.subnet_name
  virtual_network_name             = each.value.virtual_network_name
  network_resource_group_name      = each.value.network_resource_group_name
  private_ip_address_allocation    = each.value.private_ip_address_allocation
  private_ip_addresses             = each.value.private_ip_addresses
  size                             = each.value.size
  disk_size_gb                     = each.value.disk_size_gb
  custom_data                      = each.value.custom_data
  backup_policy_name               = each.value.backup_policy_name
  recovery_vault_name              = each.value.recovery_vault_name
  rsv_resource_group_name          = each.value.rsv_resource_group_name
  storage_account_type             = each.value.storage_account_type
  storage_account_name             = each.value.storage_account_name
  storage_account_access_key       = (var.exclude_diagnostics) ? null : data.azurerm_storage_account.diagnostics[each.key].primary_access_key
  storage_account_blob_endpoint    = (var.exclude_diagnostics) ? null : data.azurerm_storage_account.diagnostics[each.key].primary_blob_endpoint
  admin_password                   = data.azurerm_key_vault_secret.vm_admin_password.value
  bhp_image_reference_id           = data.azurerm_shared_image.bhp_image.id
  data_disks                       = var.data_disks
  domain                           = var.domain
  dc_password                      = data.azurerm_key_vault_secret.domain_user_secret.value
  dc_username                      = data.azurerm_key_vault_secret.domain_user_name.value
  exclude_diagnostics              = var.exclude_diagnostics
  install_iis                      = var.install_iis
  install_dotnet_framework         = var.install_dotnet_framework
  environment                      = var.environment
  tags                             = var.tags
  log_analytics                    = var.log_analytics
  datadog_enabled                  = var.datadog_enabled
  datadog_api_key                  = data.azurerm_key_vault_secret.datadog_api_key.value
  gitlab_scom_token                = data.azurerm_key_vault_secret.gitlab_scom_token.value
  app_critical                     = var.app_critical
  #appdynamics_appname              = var.app_critical.appdynamics_appname
  #appdynamics_token                = var.app_critical.appdynamics_token
  enable_app_insights              = var.enable_app_insights
  app_insights_instrumentation_key = var.app_insights_instrumentation_key
  enable_backup                    = var.enable_backup

  ### Enable and add value if default value is not suitable
  #os_disk_caching                  = ""
  #os_disk_name                     = ""
  #license_type                     = ""
  #identity_type                    = ""
  #identity_ids                     = []
  #zone                             = var.zone
  #zones                            = var.zones
}
