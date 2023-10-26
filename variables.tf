variable "vm_list" {
  description = "List of VM specs"
  type = map(object({
      base_name                     = string
      name                          = string
      computer_name                 = string
      computer_description          = string
      create_vm_resource_group      = bool
      resource_group_name           = string
      location                      = string
      virtual_network_name          = string
      network_resource_group_name   = string
      subnet_name                   = string
      size                          = string
      private_ip_address_allocation = string
      private_ip_addresses          = list(string)
      disk_size_gb                  = number
      storage_account_type          = string
      storage_account_name          = string
      storage_account_rg            = string
      custom_data                   = string
      backup_policy_name            = string
      recovery_vault_name           = string
      rsv_resource_group_name       = string    
    })
  )
}

variable "admin_password_key_vault_name" {
  description = "VM Local Admin pass keyvault name"
  type        = string
  sensitive   = true
  default     = "soe-vm-admin-password"
}

variable "enable_backup" {
  description = "Enable VM Backup (enabled by default)"
  type        = bool
  default     = true
}

variable "ops_key_vault_id" {
  description = "Azure Operations Key Vault Reference Id"
  type = string
  default = "/subscriptions/c0c8209e-5456-409b-9615-693a24c44079/resourceGroups/it-aue1-cor-spoke-share/providers/Microsoft.KeyVault/vaults/it-akv-001"
}

variable "bhp_image_reference" {
  description = "The source image from the shared services gallery"
  type = object({
    name                = string
    gallery_name        = string
    resource_group_name = string
  })
  default = {
    name                = "WindowsServer2019"
    gallery_name        = "itaue1corlzimages"
    resource_group_name = "it-aue1-cor-lz"
  }
}

variable "spoke_client_id" {
  type = string
}

variable "spoke_client_secret" {
  type = string
}

variable "spoke_sub_id" {
  type = string
}

variable "image_sub_id" {
  type    = string
  default = "c0c8209e-5456-409b-9615-693a24c44079"
}

variable "storage_account_sub_id" {
  type    = string
  default = "c0c8209e-5456-409b-9615-693a24c44079"
}

variable "exclude_diagnostics" {
  type    = bool
  default = false
}

variable "domain" {
  type = object({
    dc_shortname               = string
    dc_admin_members           = string
    dc_operator_members        = string
  })
  description = "Provider Details"
  default = {
    dc_shortname               = ""
    dc_admin_members           = ""
    dc_operator_members        = ""
  }
}

variable "dc_username_key_vault_name" {
  description = ""
  type = string
  sensitive = true
  default = "soe-dc-username"
}

variable "dc_password_key_vault_name" {
  description = ""
  type = string
  sensitive = true
  default = "soe-dc-password"
}

variable tags {
  type = map
}

variable "data_disks" {
  description = "A list of data disks to attach to the windows VM"
  type = map(object({
    name                 = string
    storage_account_type = string
    disk_size_gb         = string
    caching              = string
    lun                  = string
  }))
  default = {} 
}

variable "key_vault_sub_id" {
  description = "The Subscription ID where the Key Vault resides. Used in the azurerm.key_vault provider."
  type        = string
  default     = "c0c8209e-5456-409b-9615-693a24c44079" 
}

variable "app_critical" {
  type = object({
    is_critical         = bool
    platform            = string
    appdynamics_appname = string
    appdynamics_token   = string
  })
  description = "If this is a critical app then AppDynamics will be installed as part of post build and configuration will be done based on the environment name."
default = {
    is_critical = false    # true
    platform    = "dotnet" # "java"
    appdynamics_appname = ""
    appdynamics_token   = ""
  }
}

variable "install_iis" {
  description = "If it is set IIS and its managementtools will be installed on the VM"
  type        = bool
  default     = false
}

variable "install_dotnet_framework" {
  description = "If it is set .NET Framework will be installed on the VM"
  type        = bool
  default     = false
}

variable "enable_app_insights" {
  description = "Enable Azure Application Insights"
  type        = bool
  default     = false
}

variable "app_insights_instrumentation_key" {
  description = "Azure Application Insights Instrumentation Key"
  type        = string
  default     = "" 
}

variable "environment" {
  type        = string
  description = "The environment where the vm is getting deploy to"
}

variable "log_analytics" {
  description = "Log analytics attributes"
  type = object({
    enable_vm_insights      = bool
    resource_group_name     = string
    workspace_id            = string
    workspace_name          = string
    workspace_key           = string
    workspace_resource_id   = string
    enable_alert_rules      = bool
    email_receiver          = map(object({
      name          = string
      email_address = string
    }))
    service_uri             = string
    use_common_alert_schema = bool
    alert_description       = object({
      freespace  = string
      heartbeat  = string
      highCPU    = string
      highMemory = string
      iispool    = string
      jobfailed  = string
      w3svc      = string
    })
    alert_name              = object({
      freespace  = string
      heartbeat  = string
      highCPU    = string
      highMemory = string
      iispool    = string
      jobfailed  = string
      w3svc      = string
    })
    app_ci                  = string
    alert_hostname          = string
  })
  default = {
    enable_vm_insights    = true
    resource_group_name   = "it-prd-pet_drillpad_app-arg"
    workspace_id          = "50274861-0e43-408f-8e85-87087ff370e3"
    workspace_name        = "ussc-prd-drillpad"
    workspace_key         = "riw5byS7jRLwI9vlGQtE5RCSaG0eIyKgvFjiu/vdmx9Ot6pti/P1YimloxEl/KbcB95C7Iasmqj8b3KneKzDSA=="
    workspace_resource_id = "/subscriptions/88340066-b701-4192-8a36-8cec4399c292/resourcegroups/it-prd-pet_drillpad_app-arg/providers/microsoft.operationalinsights/workspaces/it-law-ussc-prd-drillpad"
    enable_alert_rules    = false
    email_receiver = {
      "alert1" = {
        name          = "sendtoadmin"
        email_address = "makam.mitch@bhp.com"
      },
      "alert2" = {
        name          = "sendtousers"
        email_address = "makam.mitch@bhp.com"
      }
    }
    service_uri             = "http://example.com/alert"
    use_common_alert_schema = true
    alert_description       = {
      freespace  = ""
      heartbeat  = ""
      highCPU    = ""
      highMemory = ""
      iispool    = ""
      jobfailed  = ""
      w3svc      = ""
    }
    alert_name              = {
      freespace  = ""
      heartbeat  = ""
      highCPU    = ""
      highMemory = ""
      iispool    = ""
      jobfailed  = ""
      w3svc      = ""
    }
    app_ci                  = ""
    alert_hostname          = ""
  }
}

variable "datadog_enabled" {
  type    = number
  default = 1
}

variable "zone" {
  description = "availability zone for VM"
  type    = string
  default = null
}

variable "zones" {
  description = "(Optional) A collection containing the availability zone to allocate the Managed Disk in."
  type    = list(string)
  default = []
}