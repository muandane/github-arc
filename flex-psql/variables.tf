variable "sku_name" {
  description = "Postgres Server sku name"
  type        = string
}

variable "location" {
  description = "Postgres Server location"
  type        = string
}

variable "admin-password" {
  sensitive   = true
  description = "value of admin password"
  type        = string
}
variable "admin-username" {
  sensitive   = true
  description = "value of admin username"
  type        = string
}
