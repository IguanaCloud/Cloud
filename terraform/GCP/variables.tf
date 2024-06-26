variable "project" {
  type        = string
  description = "The GCP project to deploy to."
}

variable "env" {
  type        = string
  description = "The environment to deploy to."
}

variable "region" {
  type        = string
  description = "The GCP region to deploy to."
}

variable "zone" {
  type        = string
  description = "The GCP zone to deploy to."
}

variable "app" {
  type        = string
  description = "The name of the application."
}

variable "allowed_ips" {
  type        = list(string)
  description = "The list of allowed IP addresses."
}