data "azurerm_resource_group" "rgdarkirondan" {
  name = var.nameRG
}

module "vpc" {
  source       = "./modules/vpc"
  rg           = var.nameRG
  location     = var.location
  sec_group_id = module.securiygroup.id
  vn           = var.nameVN
  nameSubN     = var.nameSubN
}
// configure in portal azure port 8200
module "securiygroup" {
  source   = "./modules/securiygroup"
  rg       = var.nameRG
  location = var.location
  port     = var.port
}

module "security" {
  source = "./modules/security"

}

module "vm"{
  source = "./modules/vm"
  rg = var.nameRG
  location = var.location
  network_interface_id = module.vpc.id
  ssh_key = module.security.ssh
  depends_on = [
    module.vpc
  ]
}