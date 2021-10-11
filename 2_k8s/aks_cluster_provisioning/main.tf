terraform {
  backend "azurerm" {
  
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.80.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks-rg" {
  name     = "devops-exercise"
  location = "UK South"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "devops-exercise"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = "devops-exercise"
  kubernetes_version  = "1.21.2"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2as_v4"
    orchestrator_version = "1.21.2"    
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "demo"
  }
}