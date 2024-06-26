variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "env" {
  description = "The Working environment"
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

variable "app" {
  description = "The application name"
  type        = string
}

variable "image_type" {
  description = "The instance OS"
  type        = string
}

variable "vpc_network" {
  description = "VPC network for resources"
  type        = string
}

variable "sub_network" {
  description = "Subnetwork for resources"
  type        = string
}

variable "deletion_protection" {
  description = "Deletion protection for instances"
  type        = bool
}

variable "jenkins_instance_type" {
  description = "The instance type for Jenkins"
  type        = string
}

variable "jenkins_disk_size" {
  description = "The disk size for Jenkins"
  type        = number
}

variable "jfrog_instance_type" {
  description = "The instance type for JFrog"
  type        = string
}

variable "jfrog_disk_size" {
  description = "The disk size for JFrog"
  type        = number
}

variable "jfrog_registry_instance_type" {
  description = "The instance type for JFrog Registry"
  type        = string
}

variable "jfrog_registry_disk_size" {
  description = "The disk size for JFrog Registry"
  type        = number
}

variable "prometheus_instance_type" {
  description = "The instance type for Prometheus"
  type        = string
}

variable "prometheus_disk_size" {
  description = "The disk size for Prometheus"
  type        = number
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "db_disk_size" {
  description = "The disk size for the database"
  type        = number
}

variable "instance_type" {
  description = "The instance type for the load balancer"
  type        = string
}
variable "create_private_ip_address" {
  description = "Whether to create a new private IP address for VPC peering"
  type        = bool
  default     = false
}
variable "enable_secret_manager" {
  description = "Whether to enable Secret Manager for this module"
  type        = bool
  default     = false
}

variable "subnet_cidr_range" {
  description = "The IP range for the subnet"
  type        = string
}

variable "allowed_ports" {
  description = "List of ports to allow in the firewall rule"
  type        = list(string)
}

variable "allowed_source_ranges" {
  description = "List of IP CIDR ranges to allow in the firewall rule"
  type        = list(string)
}