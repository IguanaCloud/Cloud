variable "username" {
  description = "The username for docker registry"
  type        = string
}

variable "password" {
  description = "The password for docker registry"
  type        = string
  sensitive   = true
}

variable "mail" {
  description = "The mail for docker registry"
  type        = string
}

variable "env" {
  description = "The Working environment"
  type        = string
  default     = "prod-01"
}

variable "app" {
  description = "The application name"
  type        = string
  default     = "gcp"
}

variable "region" {
  description = "The default region to deploy infrastructure"
  type        = string
  default     = "us-west4"
}

variable "registry_url" {
  description = "The url of Jfrog registry"
  type        = string
}

variable "helm_repo" {
  description = "The chart repository"
  type        = string
}

variable "helm_chart" {
  description = "The helm chart from repo"
  type        = string
}

variable "registry_domain" {
  description = "URL of the Docker registry"
  type        = string
}

variable "project" {
  type    = string
  default = "iguana-prod-env"
}
