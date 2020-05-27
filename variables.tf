#MAIN VARIABLES FILE
variable "appId" {    
}

variable "password" {
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default = "lexis_nexis_demo_rg"  
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned"
  default = "eastus"  
}