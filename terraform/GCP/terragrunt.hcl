locals {
  default_tfvars = "${get_terragrunt_dir()}/workspace_vars/default.tfvars"
}

terraform {
  extra_arguments "common_vars" {
    commands = ["apply", "plan", "destroy"]
    arguments = [
      "-var-file=${get_terragrunt_dir()}/workspace_vars/default.tfvars"
    ]
  }
}

generate "provider" {
  path      = "main.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket = "stage-bucket-general"
    prefix = "terraform/stage"
  }
  required_version = ">= 1.8.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
EOF
}
