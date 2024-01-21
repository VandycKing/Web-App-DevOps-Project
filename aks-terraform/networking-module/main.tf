# Create the Azure Resource Group for networking resources
resource "azurerm_resource_group" "networking_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Define the Virtual Network (Vnet) for the AKS cluster
resource "azurerm_virtual_network" "aks_vnet_rs" {
  name                = "vd-aks-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.networking_rg.name
}

# Define subnets within the Vnet for control plane 
resource "azurerm_subnet" "control_plane_subnet_rs" {
  name                 = "vd-control-plane-subnet"
  resource_group_name  = azurerm_resource_group.networking_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet_rs.name
  address_prefixes     = ["10.0.1.0/24"]

}

# Define subnets within the Vnet for the worker nodes
resource "azurerm_subnet" "worker_node_subnet_rs" {
  name                 = "vd-worker-node-subnet"
  resource_group_name  = azurerm_resource_group.networking_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet_rs.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Define Network Security Group (NSG) for the AKS subnet
resource "azurerm_network_security_group" "aks_nsg_rs" {
  name                = "vd-aks-nsg"
  location            = azurerm_resource_group.networking_rg.location
  resource_group_name = azurerm_resource_group.networking_rg.name
}

# Allow inbound traffic to kube-apiserver (TCP/443) from your public IP address
resource "azurerm_network_security_group_rule" "kube_apiserver_rs" {
  name                        = "vd-kube-api-server-rule"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "95.141.27.178"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking_rg.name
  network_security_group_name = azurerm_network_security_group.aks_nsg_rs.name
}

# Allows inbound traffic for SSH (TCP/22)
resource "azurerm_network_security_group_rule" "ssh_rule_rs" {
  name                        = "vd-ssh-rule"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "95.141.27.178"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking_rg.name
  network_security_group_name = azurerm_network_security_group.aks_nsg_rs.name
}
