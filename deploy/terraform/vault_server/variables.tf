variable "nameVN" {
  default     = "vn-security"
  description = "name of virtual network"
}

variable "nameRG" {
    default     = "rg-tf"
    description = "name of resource group"
}

variable "location" {
    default     = "centralus"
    description = "location of resource group"
}

variable "nameSubN" {
    default     = "subnet-security"
    description = "name of subnet"
}

variable "port" {
    default     = "22"
    description = "port of container"
}
