# module "resource_group" {
#   source   = "./modules/rg"
#   rg_name  = var.rg_name
#   location = var.location
# }

module "container_registry" {
  source   = "./modules/acr"
  acr_name = var.acr_name
  rg_name  = var.rg_name
  location = var.rg_location
}

module "cosmosdb" {
  source      = "./modules/cosmos"
  cosmos_name = var.cosmos_name
  rg_name     = var.rg_name
  location    = var.rg_location
}

module "aks" {
  source   = "./modules/aks"
  aks_name = var.aks_name
  acr_id   = module.container_registry.acr-id
  rg_name  = var.rg_name
  #location = module.resource_group.rg_location
  location = "westus2"
}

# Resource group for vm, to solve regional quota
# resource "azurerm_resource_group" "rg-centralus" {
#   name     = "rg-tf-centraus"
#   location = "Central Us"
# }

# module "vm-vault" {
#   source  = "./modules/vm-vault"
#   rg_name = azurerm_resource_group.rg-centralus.name
#   #rg_name          = module.resource_group.rg-name
#   #location         = module.resource_group.rg-location
#   location         = azurerm_resource_group.rg-centralus.location
#   vault_image_name = var.vault_image_name
#   admin_username   = var.admin_username
#   admin_password   = var.admin_password
#   vm_size          = var.vm_size

#   depends_on = [
#     module.resource_group
#   ]
# }


/*
module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${module.resource_group.resource_group_name}"
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${module.resource_group.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group   = "${module.resource_group.resource_group_name}"
}
*/