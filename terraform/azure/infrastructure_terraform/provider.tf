provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "main-resources"
  location =  "eastus"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstatesa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}