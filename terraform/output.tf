output "storage_account_name" {
  value = azurerm_storage_account.name
}

output "static_website_address" {
  value = data.azure_storage_account.main.primary_web_host
}
