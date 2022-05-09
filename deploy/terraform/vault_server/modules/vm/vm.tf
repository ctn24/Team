# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.rg
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
  name                     = "sec${random_id.randomId.hex}"
  location                 = var.location
  resource_group_name      = var.rg
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = "Security-VM"
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [var.network_interface_id] // azurerm_network_interface.myterraformnic.id]
  size                  = "Standard_DS1"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/d9eadbf1-cd33-4831-86ff-6f0ce120d40c/resourceGroups/rg-tf/providers/Microsoft.Compute/images/Vault-image"

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key =var.ssh_key // tls_private_key.example_ssh.public_key_openssh
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
  }
}
