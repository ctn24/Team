# Locate the existing custom image
data "azurerm_image" "vault-image" {
  name                = var.vault_image_name
  #resource_group_name = var.rg_name
  resource_group_name = "rg-tf"
}

# Create a Network Security Group with some rules
resource "azurerm_network_security_group" "sg" {
  name                = "sg-tf"
  location            = var.location
  resource_group_name = var.rg_name
  
  # activar los puertos 22 (para entrar por ssh) y 8200 (para alcanzar la UI de vault)
  security_rule {
    name                       = "sgr-ssh-22-tf"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "sgr-vaultUI-8200-tf"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8200"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# Create virtual network
resource "azurerm_virtual_network" "vn" {
  name                = "vn-tf"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-tf"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create public IP
resource "azurerm_public_ip" "public-ip" {
  name                = "public-ip-f"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = "nic-tf"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
}

# Create a new Virtual Machine based on the custom Image
resource "azurerm_virtual_machine" "vm-vault" {
  name                             = "vm-vault-tf"
  location                         = var.location
  resource_group_name              = var.rg_name
  network_interface_ids            = [azurerm_network_interface.nic.id]
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.vault-image.id
  }

  storage_os_disk {
    name              = "vm-vault-tf-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
}

  os_profile {
    computer_name  = "vm-vault-tf"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  
    ssh_keys{
      //key_data = file("~/.ssh/tf_id_rsa.pub")
      key_data = file("tf_id_rsa.pub")
      path = "../../"
    }
  }
  
  tags = {
    environment = "Production"
  }
}

