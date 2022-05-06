output "cosmos-name" {
  value = azurerm_cosmosdb_account.cosmosdbaccount.name
}

output "cosmos-connection_string" {
  value = azurerm_cosmosdb_account.cosmosdbaccount.connection_strings
}

output "cosmos-id" {
  value = azurerm_cosmosdb_account.cosmosdbaccount.id
}