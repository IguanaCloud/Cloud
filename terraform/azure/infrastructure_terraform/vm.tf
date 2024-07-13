resource "azurerm_linux_virtual_machine" "vm" {
  count                           = 2
  name                            = "VM-${count.index}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1ls"
  admin_username                  = "adminuser"
  network_interface_ids           = [azurerm_network_interface.nic[count.index].id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/my_azure_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx
EOF
  )
}