terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Sunwing"

    workspaces {
      prefix = "pcs-"
    }
  }
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

data "azurerm_client_config" "current" {

}

resource "azurerm_resource_group" "this" {
  name     = "${var.env}-RGASVCAPI01"
  location = var.location
}
