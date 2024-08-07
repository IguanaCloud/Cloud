variable "project" {
  description = "Google cloud active project"
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
  description = "The availability zone where the resource will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "The VPC id"
  type        = string
}

variable "subnet_id" {
  description = "The VPC id"
  type        = string
}

locals {
  full_name = "${var.env}-${var.region}-${var.app}"
}