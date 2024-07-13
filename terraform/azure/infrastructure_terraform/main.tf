
module "azure_instance" {
    source = "./modules/instance"
    network_interface = module.azure_network.main_network_interface
    resource_group = azurerm_resource_group.main
}

module "azure_network" {
    source = "./modules/network"
    resource_group = azurerm_resource_group.main
}