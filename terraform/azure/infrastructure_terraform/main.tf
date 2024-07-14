terraform {
   backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate7fqc5"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_version = ">= 1.8.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30.0"
    }
  }
}

provider "azurerm" {
  features {}
}










