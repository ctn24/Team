resource "azurerm_cosmosdb_account" "cosmosdbaccount" {
  name                = var.cosmos_name
  resource_group_name = var.rg_name
  location            = var.location

  offer_type = "Standard"
  kind       = "MongoDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }


  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

# {
#     "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
#     "contentVersion": "1.0.0.0",
#     "parameters": {
#         "name": {
#             "type": "String"
#         }
#     },
#     "variables": {
#         "name": "[concat(parameters('name'), uniqueString(resourceGroup().id))]",
#         "location":"[resourceGroup().location]"
#     },
#     "resources": [
#         {
#             "type": "Microsoft.DocumentDb/databaseAccounts",
#             "kind": "MongoDB",
#             "name": "[variables('name')]",
#             "apiVersion": "2015-04-08",
#             "location": "[variables('location')]",
#             "properties": {
#                 "databaseAccountOfferType": "Standard",
#                 "locations": [
#                     {
#                         "id": "[concat(variables('name'), '-', variables('location'))]",
#                         "failoverPriority": 0,
#                         "locationName": "[variables('location')]"
#                     }
#                 ]
#             }
#         }
#     ]
# }