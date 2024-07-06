variable "vpc_id" {
  description = "The VPC id"
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

variable "project" {
  description = "The GCP project ID"
  type        = string
}

locals {
  full_name = "${var.env}-${var.region}-${var.app}"
}
