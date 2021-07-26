output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "static_website_address" {
  value = "https://${azurerm_storage_account.main.primary_web_host}/"
}