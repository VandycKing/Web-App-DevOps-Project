output "resource_group_name" {
  value       = azurerm_resource_group.networking_rg.name
  description = "The name of the resource group created for networking resources."
}

output "vnet_id" {
  value       = azurerm_virtual_network.aks_vnet_rs.id
  description = "The ID of the virtual network created for the AKS cluster."
}

output "control_plane_subnet_id" {
  value       = azurerm_subnet.control_plane_subnet_rs.id
  description = "The ID of the subnet created for the AKS control plane."
}

output "worker_node_subnet_id" {
  value       = azurerm_subnet.worker_node_subnet_rs.id
  description = "The ID of the subnet created for the AKS worker nodes."
}

output "aks_nsg_id" {
  value       = azurerm_network_security_group.aks_nsg_rs.id
  description = "The ID of the network security group associated with the AKS cluster."
}
