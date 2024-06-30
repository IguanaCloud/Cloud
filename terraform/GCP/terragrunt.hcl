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

inputs = {
  project                      = "iguana-dev-env"
  env                          = "dev"
  region                       = "us-central1"
  zone                         = "us-central1-a"
  app                          = "iguana"
  image_type                   = "debian-cloud/debian-11"
  vpc_network                  = "dev-us-central1-iguana-vpc-cluster"
  sub_network                  = "dev-us-central1-iguana-subnet-cluster"
  vpc_id                       = "projects/iguana-dev-env/global/networks/dev-us-central1-iguana-vpc-cluster"
  deletion_protection          = false
  db_disk_size                 = 20
  db_instance_type             = "db-f1-micro"
  lb_instance_type             = "e2-small"
  create_private_ip_address    = true
  enable_secret_manager        = true
  instance_type                = "e2-small"
  disk_size                    = 50
  gke_num_nodes                = 3
  gke_disk_size                = 20
  app_additional               = "gitea"
  region_additional            = "us-west1"

  allowed_ips                  = local.sensitive_vars.allowed_ips
  database_subnet_cidr_range   = local.sensitive_vars.database_subnet_cidr_range
  database_allowed_ports       = local.sensitive_vars.database_allowed_ports
  database_allowed_source_ranges = local.sensitive_vars.database_allowed_source_ranges
  lb_geo_subnet_cidr_range     = local.sensitive_vars.lb_geo_subnet_cidr_range
  lb_geo_allowed_ports         = local.sensitive_vars.lb_geo_allowed_ports
  lb_geo_allowed_source_ranges = local.sensitive_vars.lb_geo_allowed_source_ranges
  gke_subnet_cidr              = local.sensitive_vars.gke_subnet_cidr
  vm_subnet_cidr               = local.sensitive_vars.vm_subnet_cidr
  allowed_ports                = local.sensitive_vars.allowed_ports
  allowed_source_ranges        = local.sensitive_vars.allowed_source_ranges

  secrets                      = local.secrets
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("C:/Users/anton/Desktop/geocity-main/iguana-dev-env-a78c1cef537d.json")
}

provider "google-beta" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("C:/Users/anton/Desktop/geocity-main/iguana-dev-env-a78c1cef537d.json")
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket      = "iguana-dev-env-tf-state"
    prefix      = "terraform/${path_relative_to_include()}"
    credentials = "C:/Users/anton/Desktop/geocity-main/iguana-dev-env-a78c1cef537d.json"
  }
}
EOF
}

generate "secrets" {
  path      = "secrets.tf"
  if_exists = "overwrite"
  contents  = <<EOF
%{ for secret_key, secret_value in local.secrets }
resource "google_secret_manager_secret" "${secret_key}" {
  secret_id = "${secret_value.secret_id}"
  
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "${secret_key}" {
  secret = google_secret_manager_secret.${secret_key}.id
  secret_data = "${secret_value.secret_data}"
}
%{ endfor }
EOF
}