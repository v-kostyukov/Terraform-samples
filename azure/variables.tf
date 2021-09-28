variable "prefix" {
  type        = string
  description = "(optional) describe your variable"
}

variable "location" {
  type        = string
  description = "Location where your resource needs to provision in azure"
  default     = "northeurope"
}

#variable "subscription_id" {
#  type        = string
#  description = "Location where your resource needs to provision in azure"
#  default     = "northeurope"
#}
#
#variable "client_id" {
#  type        = string
#  description = "Location where your resource needs to provision in azure"
#  default     = "northeurope"
#}
#
#variable "client_secret" {
#  type        = string
#  description = "Location where your resource needs to provision in azure"
#  default     = "northeurope"
#}
#
#variable "tenant_id" {
#  type        = string
#  description = "Location where your resource needs to provision in azure"
#  default     = "northeurope"
#}