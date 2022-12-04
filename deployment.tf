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
    client_id = "eaca2cf8-b7fb-4a1a-bb70-8ba205689ac5"  
    client_secret ="svk8Q~4qUkS7Ba9ZpUx35.S5S4a4-vJMrGJgZb8A" 
    tenant_id = "0df31d06-8b24-4218-90a0-e08bb052bef6"
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
