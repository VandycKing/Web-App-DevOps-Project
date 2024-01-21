
variable "resource_group_name" {
  description = "Specifies the name of the resource group where the virtual network will be deployed."
  type        = string
}

variable "location" {
  description = "Specifies the location/region where the virtual network will be deployed"
  type        = list(string)
}

variable "vnet_address_space" {
  description = "Specifies the address space for the virtual network."
  type        = string
}
