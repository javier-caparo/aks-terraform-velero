terraform {
  required_version = "~> 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.3"
    }
  }
}

provider "azurerm" {
  features {}
}