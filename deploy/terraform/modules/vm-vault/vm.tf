# resource "azurerm_virtual_network" "vnet" {
#   name                = "vmliux-vnet"
#   address_space       = ["10.0.0.0/16", "192.168.0.0/16"]
#   location            = var.location
#   resource_group_name = var.rg_name

# }

# resource "azurerm_subnet" "subnet" {
#   name                 = "vmliux-subnet"
#   resource_group_name  = var.rg_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_public_ip" "publicip" {
#   name                    = "vmliux-ippublic"
#   location                = var.location
#   resource_group_name     = var.rg_name
#   allocation_method       = "Dynamic"
#   idle_timeout_in_minutes = 30
#   domain_name_label       = "vmliuxtf"
# }

# resource "azurerm_network_interface" "nic" {
#   name                = "vmliux-nic"
#   location            = var.location
#   resource_group_name = var.rg_name

#   ip_configuration {
#     name                          = "ipexterno-config"
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.publicip.id
#   }
# }

# resource "azurerm_network_security_group" "nsg" {
#   name                = "vmliux-nsg"
#   location            = var.location
#   resource_group_name = var.rg_name

# }


# variable "input_rules" {
#   type = map(any)
#   default = {
#     101 = 80
#     102 = 443
#     103 = 3389
#     104 = 22
#   }
# }


# resource "azurerm_network_security_rule" "input_rules_liberada" {
#   for_each                    = var.input_rules
#   resource_group_name         = var.rg_name
#   name                        = "porta_entrada_${each.value}"
#   priority                    = each.key
#   direction                   = "Inbound"
#   access                      = "Allow"
#   source_port_range           = "*"
#   protocol                    = "Tcp"
#   destination_port_range      = each.value
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   network_security_group_name = azurerm_network_security_group.nsg.name

# }

# resource "azurerm_subnet_network_security_group_association" "nsgassociacao" {
#   subnet_id                 = azurerm_subnet.subnet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }


# resource "azurerm_linux_virtual_machine" "vmlinux" {
#   name                = "vmlinuxserver"
#   resource_group_name = var.rg_name
#   location            = var.location

#   size                  = "Standard_B1ls"
#   admin_username        = "adminuser"
#   admin_password        = "senha"
#   network_interface_ids = [azurerm_network_interface.nic.id]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"

#   }
# }

