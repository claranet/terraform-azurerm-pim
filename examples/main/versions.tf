terraform {
  required_version = ">= 1.8"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.3"
    }
  }
}
provider "azuread" {
  tenant_id = var.azure_tenant_id
}
