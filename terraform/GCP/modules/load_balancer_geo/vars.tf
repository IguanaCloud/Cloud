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

variable "app" {
  description = "The application name"
  type        = string
}

variable "vpc_network" {
  description = "The VPC network name"
  type        = string
}

variable "sub_network" {
  description = "The subnetwork name"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the load balancer"
  type        = string
}

variable "image_type" {
  description = "The image type for the load balancer instances"
  type        = string
}
variable "zone" {
  description = "The zone where resources will be created"
  type        = string
}

variable "create_private_ip_address" {
  description = "Whether to create a private IP address for database peering"
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