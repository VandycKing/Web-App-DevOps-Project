
variable "client_id" {
  description = "Specifies the id to the azure service principal"
  type        = string
}

variable "client_secret" {
  description = "Specifies the password of the azure service principal"
  type        = string
}

variable "subscription_id" {
  description = "The subscription id where the resources will be created at."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant id."
  type        = string
}
