terraform {
  required_version = ">=0.14.8"
  required_providers {
    azurerm = {
      version = "~> 2.40.0"
    }
  }
}

locals {
  tenant-id = "4f6e1565-c2c7-43cb-8a4c-0981d022ce20"
}