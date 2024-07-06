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

variable "geo_sub_network" {
  description = "The subnetwork name"
  type        = string
}

variable "zone" {
  description = "The zone where resources will be created"
  type        = string
}

locals {
  full_name = "${var.env}-${var.region}-${var.app}"
}


