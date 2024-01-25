
variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "cluster_location" {
  description = "Specifies the azure region where the AKS cluster will be deployed"
  type        = string
}

variable "dns_prefix" {
  description = "Specifies the DNS prefix of the cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to use for creating the AKS managed Kubernetes cluster."
  type        = string
}


variable "service_principal_client_id" {
  description = "Specifies the Client ID for the service principal associated with the cluster"
  type        = string
}

variable "service_principal_secret" {
  description = "Specifies the Secret used by the service principal"
  type        = string
}

# Output variables from the networking module as input variables for this module
variable "resource_group_name" {
  description = "Name of the resource group for networking resources"
  type        = string
}

variable "vnet_id" {
  description = "ID of the Virtual Network created by the networking module"
  type        = string
}

variable "control_plane_subnet_id" {
  description = "ID of the control plane subnet created by the networking module"
  type        = string
}

variable "worker_node_subnet_id" {
  description = "ID of the worker node subnet created by the networking module"
  type        = string
}

variable "aks_nsg_id" {
  description = "ID of the NSG"
  type        = string
}
