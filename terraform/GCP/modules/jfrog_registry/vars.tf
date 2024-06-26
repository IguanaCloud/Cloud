variable "project" {
  description = "Google cloud active project"
  type        = string
}

variable "env" {
  description = "The Working environment"
  type        = string
}

variable "app" {
  description = "The application name"
  type        = string
}

variable "region" {
  description = "The default region to deploy infrastructure"
  type        = string
}

variable "zone" {
  description = "The availability zone where the resource will be deployed"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "image_type" {
  description = "The instance OS"
  type        = string
}

variable "vpc_network" {
  description = "Vpc network for resources"
  type        = string
}

variable "sub_network" {
  description = "Subnetwork network for resources"
  type        = string
}

variable "disk_size" {
  description = "The size of the disk"
  type        = number
}

variable "deletion_protection" {
  description = "Deletion protection for instances"
  type        = bool
}
variable "enable_secret_manager" {
  description = "Whether to enable Secret Manager for this module"
  type        = bool
  default     = false
}
