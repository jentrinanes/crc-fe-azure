terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"  
}

provider "azurerm" {
  features {

  }
}

# Create a resource group

resource "azurerm_resource_group" "rg" {
  name     = "crc-rg-test"
  location = "southeastasia"
}

# Create a storage account

resource "azurerm_storage_account" "sa" {
    name = "crc-sa-test"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"

    static_website {
        index_document = "index.html"
        error_404_document = "404.html"     
    }

    tags = {
        environment = "test"
    }
}

