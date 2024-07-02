variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "env" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}

variable "app" {
  description = "The application name"
  type        = string
}

variable "vpc_network" {
  description = "The VPC network name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "db_instance_type" {
  description = "The instance type for the database"
  type        = string
}

variable "db_disk_size" {
  description = "The disk size for the database in GB"
  type        = number
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

variable "create_private_ip_address" {
  description = "Whether to create a private IP address for the database"
  type        = bool
}

variable "enable_secret_manager" {
  description = "Whether to enable Secret Manager for storing database credentials"
  type        = bool
}

variable "gke_subnet_cidr" {
  description = "The CIDR range of the GKE subnet"
  type        = string
}

variable "vm_subnet_cidr" {
  description = "The CIDR range of the subnet containing VM instances"
  type        = string
}
