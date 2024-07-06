variable "env" {
  type        = string
  description = "The environment to deploy to."
}

variable "region" {
  type        = string
  description = "The GCP region to deploy to."
}

variable "app" {
  type        = string
  description = "The name of the application."
}

variable "project" {
  description = "The GCP project ID"
  type        = string
}

locals {
  full_name = "${var.env}-${var.region}-${var.app}"
}
