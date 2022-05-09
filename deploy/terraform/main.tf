module "container_registry" {
  source   = "./modules/acr"
  acr_name = var.acr_name
  rg_name  = var.rg_name
  location = var.rg_location
}

output "acr_credentials" {
  value = module.container_registry.admin-password
  sensitive = true
}

module "aks" {
  source   = "./modules/aks"
  aks_name = var.aks_name
  acr_id   = module.container_registry.acr-id
  rg_name  = var.rg_name
  #location = module.resource_group.rg_location
  location = "westus2"
}

resource "vault_generic_secret" "example" {
  path = "secret/acr"

  data_json = jsonencode(
    {
      "acr_pass"   = module.container_registry.admin-password
    }
  )
}

//clean