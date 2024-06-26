variable "project" {
  description = "The GCP project ID"
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
  description = "The zone where resources will be created"
  type        = string
}

variable "instance_type" {
  description = "The instance type for Jenkins"
  type        = string
}

variable "image_type" {
  description = "The image type for Jenkins"
  type        = string
}

variable "vpc_network" {
  description = "VPC network for Jenkins resources"
  type        = string
}

variable "sub_network" {
  description = "Subnetwork for Jenkins resources"
  type        = string
}

variable "disk_size" {
  description = "The size of the disk for Jenkins"
  type        = number
}

variable "deletion_protection" {
  description = "Deletion protection for Jenkins instances"
  type        = bool
}

variable "disk_snapshot" {
  description = "The snapshot of the disk"
  type        = string
  default     = ""
}
variable "enable_secret_manager" {
  description = "Whether to enable Secret Manager for this module"
  type        = bool
  default     = false
}

