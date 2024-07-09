variable "username" {
  description = "The username for docker registry"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "The password for docker registry"
  type        = string
  sensitive   = true
  default     = "User1234%"
}

variable "mail" {
  description = "The mail for docker registry"
  type        = string
  default     = "yura@gmail.com"
}

variable "env" {
  description = "The Working environment"
  type        = string
  default     = "dev-01"
}

variable "app" {
  description = "The application name"
  type        = string
  default     = "gcp"
}

variable "region" {
  description = "The default region to deploy infrastructure"
  type        = string
  default     = "us-east1"
}

variable "registry_url" {
  description = "The url of Jfrog registry"
  type        = string
  default     = "registry.iguana-devops.pp.ua/docker-local"
}

variable "helm_repo" {
  description = "The chart repository"
  type        = string
  default     = "gogs-repo"
}

variable "helm_chart" {
  description = "The helm chart from repo"
  type        = string
  default     = "gogsapp"
}

variable "registry_domain" {
  description = "URL of the Docker registry"
  type        = string
  default     = "registry.iguana-devops.pp.ua"
}