output "storage_account_name" {
  value = azurerm_storage_account.name
}

output "static_website_address" {
  value = azure_storage_account.primary_web_endpoint
}
