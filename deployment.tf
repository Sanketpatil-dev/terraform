terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "3.32.0"
    }
  }
}
provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
  name = "Devops-Pathways-Webapp"
  location = "eastus"

}

resource "azurerm_service_plan" "service_plan" {
  name="Devops_Service_Plan1"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type = "Linux"
  sku_name = "P1v2"
  
}

resource "azurerm_linux_web_app" "Webapp" {
    name = "Devops-prod-pathways1"
    location = azurerm_resource_group.rg.location
    service_plan_id = azurerm_service_plan.service_plan.id
    resource_group_name = azurerm_resource_group.rg.name
  
    site_config {
        scm_minimum_tls_version = "1.2"
        application_stack {
            python_version="3.10"
            
            }
        }
        
    }





resource "azurerm_app_service_source_control" "source_control" {
  app_id = azurerm_linux_web_app.Webapp.id
  repo_url = "https://github.com/Sanketpatil-dev/group-proj"
  branch = "master" 
}