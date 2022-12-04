
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
   subscription_id = "4379ddc6-d045-4d91-9844-52690a3371a8" 
    tenant_id = "0df31d06-8b24-4218-90a0-e08bb052bef6"
    client_id = "0df82684-6fcb-4de6-a1f8-62c8f2a9812e"
    client_secret = "Bq88Q~ppC8LBX9Fd3yC.a6unFLndlWemjiPV1aRV"
}

resource "azurerm_resource_group" "rg" {
  name = "Devops-Pathways-Webapp"
  location = "eastus"

}

resource "azurerm_service_plan" "service_plan" {
  name="Devops_Service_Plan"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type = "Linux"
  sku_name = "P1v2"
  
}

resource "azurerm_linux_web_app" "Webapp" {
    name = "Devops-prod-pathways"
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
