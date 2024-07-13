resource "azurerm_linux_virtual_machine" "main" {
  name                            = "main-vm"
  resource_group_name             = var.resource_group.name
  location                        = "eastus"
  size                            = "Standard_D2s_v3"
  admin_username                  = "adminuser"
  admin_password                  = "The$admin#password"
  disable_password_authentication = false
  network_interface_ids = [
    var.network_interface,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}