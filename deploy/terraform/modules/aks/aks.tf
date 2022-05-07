resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name

  dns_prefix = var.aks_name
  http_application_routing_enabled = true
  kubernetes_version = "1.21.7"

  default_node_pool {
    name                  = "agentpool"
    node_count            = 1
    vm_size               = "Standard_D4ds_v5"
    #orchestrator_version  = "1.21.7"
    enable_node_public_ip = false
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "aks_acr" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

## ARM k8s working cluster
# {
#     "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
#     "contentVersion": "1.0.0.0",
#     "parameters": {
#         "registries_containerjp01_name": {
#             "defaultValue": "containerjp01",
#             "type": "String"
#         },
#         "managedClusters_ctn_cluster_name": {
#             "defaultValue": "ctn-cluster",
#             "type": "String"
#         },
#         "workspaces_defaultworkspace_d9eadbf1_cd33_4831_86ff_6f0ce120d40c_cus_externalid": {
#             "defaultValue": "/subscriptions/d9eadbf1-cd33-4831-86ff-6f0ce120d40c/resourceGroups/defaultresourcegroup-cus/providers/microsoft.operationalinsights/workspaces/defaultworkspace-d9eadbf1-cd33-4831-86ff-6f0ce120d40c-cus",
#             "type": "String"
#         },
#         "publicIPAddresses_b886531e_2fa0_4cb7_8362_cfcc4872c5c4_externalid": {
#             "defaultValue": "/subscriptions/d9eadbf1-cd33-4831-86ff-6f0ce120d40c/resourceGroups/MC_ctn-k8s_ctn-cluster_westus2/providers/Microsoft.Network/publicIPAddresses/b886531e-2fa0-4cb7-8362-cfcc4872c5c4",
#             "type": "String"
#         },
#         "userAssignedIdentities_ctn_cluster_agentpool_externalid": {
#             "defaultValue": "/subscriptions/d9eadbf1-cd33-4831-86ff-6f0ce120d40c/resourceGroups/MC_ctn-k8s_ctn-cluster_westus2/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ctn-cluster-agentpool",
#             "type": "String"
#         }
#     },
#     "variables": {},
#     "resources": [
#         {
#             "type": "Microsoft.ContainerRegistry/registries",
#             "apiVersion": "2021-12-01-preview",
#             "name": "[parameters('registries_containerjp01_name')]",
#             "location": "centralus",
#             "sku": {
#                 "name": "Standard",
#                 "tier": "Standard"
#             },
#             "properties": {
#                 "adminUserEnabled": true,
#                 "policies": {
#                     "quarantinePolicy": {
#                         "status": "disabled"
#                     },
#                     "trustPolicy": {
#                         "type": "Notary",
#                         "status": "disabled"
#                     },
#                     "retentionPolicy": {
#                         "days": 7,
#                         "status": "disabled"
#                     },
#                     "exportPolicy": {
#                         "status": "enabled"
#                     }
#                 },
#                 "encryption": {
#                     "status": "disabled"
#                 },
#                 "dataEndpointEnabled": false,
#                 "publicNetworkAccess": "Enabled",
#                 "networkRuleBypassOptions": "AzureServices",
#                 "zoneRedundancy": "Disabled",
#                 "anonymousPullEnabled": false
#             }
#         },
#         {
#             "type": "Microsoft.ContainerService/managedClusters",
#             "apiVersion": "2022-02-02-preview",
#             "name": "[parameters('managedClusters_ctn_cluster_name')]",
#             "location": "westus2",
#             "sku": {
#                 "name": "Basic",
#                 "tier": "Free"
#             },
#             "identity": {
#                 "type": "SystemAssigned"
#             },
#             "properties": {
#                 "kubernetesVersion": "1.21.7",
#                 "dnsPrefix": "[concat(parameters('managedClusters_ctn_cluster_name'), '-dns')]",
#                 "agentPoolProfiles": [
#                     {
#                         "name": "agentpool",
#                         "count": 1,
#                         "vmSize": "Standard_D4ds_v5",
#                         "osDiskSizeGB": 128,
#                         "osDiskType": "Ephemeral",
#                         "kubeletDiskType": "OS",
#                         "maxPods": 110,
#                         "type": "VirtualMachineScaleSets",
#                         "availabilityZones": [
#                             "1",
#                             "2",
#                             "3"
#                         ],
#                         "enableAutoScaling": false,
#                         "powerState": {
#                             "code": "Running"
#                         },
#                         "orchestratorVersion": "1.21.7",
#                         "enableNodePublicIP": false,
#                         "mode": "System",
#                         "osType": "Linux",
#                         "osSKU": "Ubuntu",
#                         "enableFIPS": false
#                     }
#                 ],
#                 "servicePrincipalProfile": {
#                     "clientId": "msi"
#                 },
#                 "addonProfiles": {
#                     "azureKeyvaultSecretsProvider": {
#                         "enabled": false
#                     },
#                     "azurepolicy": {
#                         "enabled": false
#                     },
#                     "httpApplicationRouting": {
#                         "enabled": true,
#                         "config": {
#                             "HTTPApplicationRoutingZoneName": "60758cae2c9a4b3bbf43.westus2.aksapp.io"
#                         }
#                     },
#                     "omsAgent": {
#                         "enabled": true,
#                         "config": {
#                             "logAnalyticsWorkspaceResourceID": "[parameters('workspaces_defaultworkspace_d9eadbf1_cd33_4831_86ff_6f0ce120d40c_cus_externalid')]"
#                         }
#                     }
#                 },
#                 "nodeResourceGroup": "[concat('MC_ctn-k8s_', parameters('managedClusters_ctn_cluster_name'), '_westus2')]",
#                 "enableRBAC": true,
#                 "networkProfile": {
#                     "networkPlugin": "kubenet",
#                     "loadBalancerSku": "Standard",
#                     "loadBalancerProfile": {
#                         "managedOutboundIPs": {
#                             "count": 1
#                         },
#                         "effectiveOutboundIPs": [
#                             {
#                                 "id": "[parameters('publicIPAddresses_b886531e_2fa0_4cb7_8362_cfcc4872c5c4_externalid')]"
#                             }
#                         ]
#                     },
#                     "podCidr": "10.244.0.0/16",
#                     "serviceCidr": "10.0.0.0/16",
#                     "dnsServiceIP": "10.0.0.10",
#                     "dockerBridgeCidr": "172.17.0.1/16",
#                     "outboundType": "loadBalancer"
#                 },
#                 "aadProfile": {
#                     "managed": true,
#                     "adminGroupObjectIDs": [
#                         "521d8ebe-bdc4-401c-87e8-7dcf3ab02835"
#                     ],
#                     "tenantID": "3d76d15e-3586-4ab5-be8a-3639481a65d8"
#                 },
#                 "apiServerAccessProfile": {
#                     "enablePrivateCluster": false
#                 },
#                 "identityProfile": {
#                     "kubeletidentity": {
#                         "resourceId": "[parameters('userAssignedIdentities_ctn_cluster_agentpool_externalid')]",
#                         "clientId": "e57b81d3-af82-44c9-821a-6325f81ca3ef",
#                         "objectId": "acbb4ca6-e13a-4559-a795-7c0175da4fb9"
#                     }
#                 },
#                 "securityProfile": {},
#                 "oidcIssuerProfile": {
#                     "enabled": false
#                 }
#             }
#         },
#         {
#             "type": "Microsoft.ContainerService/managedClusters/agentPools",
#             "apiVersion": "2022-02-02-preview",
#             "name": "[concat(parameters('managedClusters_ctn_cluster_name'), '/agentpool')]",
#             "dependsOn": [
#                 "[resourceId('Microsoft.ContainerService/managedClusters', parameters('managedClusters_ctn_cluster_name'))]"
#             ],
#             "properties": {
#                 "count": 1,
#                 "vmSize": "Standard_D4ds_v5",
#                 "osDiskSizeGB": 128,
#                 "osDiskType": "Ephemeral",
#                 "kubeletDiskType": "OS",
#                 "maxPods": 110,
#                 "type": "VirtualMachineScaleSets",
#                 "availabilityZones": [
#                     "1",
#                     "2",
#                     "3"
#                 ],
#                 "enableAutoScaling": false,
#                 "powerState": {
#                     "code": "Running"
#                 },
#                 "orchestratorVersion": "1.21.7",
#                 "enableNodePublicIP": false,
#                 "mode": "System",
#                 "osType": "Linux",
#                 "osSKU": "Ubuntu",
#                 "enableFIPS": false
#             }
#         }
#     ]
# }