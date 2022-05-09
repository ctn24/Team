# Create Network Security Group and rule
resource "azurerm_network_security_group" "sec_group" {
  name                = "myNetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.rg

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}