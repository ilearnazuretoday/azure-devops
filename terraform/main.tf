resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_abbrev}-${local.region_abbrev}-${local.environment_abbrev}"
  location = var.location
}
resource "azurerm_storage_account" "main" {
  name                     = "salearningazuredevops"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
  }

  tags = {
    ManagedBy       = "Learning Azure DevOps"
    ProvisionedWith = "Terraform"
  }
}
