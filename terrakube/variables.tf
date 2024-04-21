variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "ssh_public_key" {
  type        = string
  description = "Cluster SSH key"
  sensitive   = true
}

variable "os_disk_size" {
  description = "The size of the os disk"
  type        = number
}

variable "default_node_pool_vm_size" {
  type        = string
  description = "The size of the default node pool"
  default     = "Standard_B2als_v2"
}

variable "default_node_pool_node_count" {
  type        = number
  description = "The number of nodes in the default node pool"
}

variable "tags" {
  type        = map(string)
  description = "AKS cluster tags"
}
variable "managed_identity_name" {
  type        = string
  description = "Managed identity name for the AKS cluster"
}
variable "managed_identity_rg" {
  type        = string
  description = "Resource group name containing the managed identity"
}
variable "github_pat" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token"
}
variable "github_url" {
  type        = string
  description = "Organization GitHub URL"

}
variable "ovh_application_secret" {
  sensitive   = true
  type        = string
  description = "ovh application secret"
}
variable "ovh_consumer_key" {
  sensitive   = true
  type        = string
  description = "ovh consumer secret"
}
variable "ovh_application_key" {
  sensitive   = true
  type        = string
  description = "ovh application key"
}
variable "acme_email" {
  type        = string
  description = "ovh acme email"
}
