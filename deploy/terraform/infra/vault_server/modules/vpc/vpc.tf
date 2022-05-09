#Creating Vitual Network
resource "azurerm_virtual_network" "example" {
  name                = var.vn
  resource_group_name = var.rg
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = var.nameSubN
  resource_group_name  = var.rg
  virtual_network_name = var.vn
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.example
  ]
}

# Create public IPs
resource "azurerm_public_ip" "public_ip" {
  name                = "PublicIP"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "myterraformnic" {
  name                = "myNIC"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  depends_on = [
    azurerm_subnet.myterraformsubnet
  ]
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.myterraformnic.id
  network_security_group_id = var.sec_group_id
}
