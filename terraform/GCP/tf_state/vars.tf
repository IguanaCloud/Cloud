variable "project" {
  description = "Google Cloud project ID"
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
  description = "The default zone to deploy infrastructure"
  type        = string
}
