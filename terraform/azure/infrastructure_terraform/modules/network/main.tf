resource "azurerm_virtual_network" "main" {
  name                = "main-network"
  address_space       = ["10.0.0.0/22"]
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                = "main-nic"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}