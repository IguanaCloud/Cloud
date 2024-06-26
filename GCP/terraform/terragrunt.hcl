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
  project                      = "iconic-ducking-9999-n0" #example name of the project
  env                          = "dev-01"
  region                       = "us-central1"
  zone                         = "us-central1-a"
  app                          = "geo"
  image_type                   = "debian-cloud/debian-11"
  vpc_network                  = "default"
  sub_network                  = "default"
  vpc_id                       = "projects/iconic-ducking-9999-n0/global/networks/default"
  deletion_protection          = false
  jenkins_instance_type        = "e2-medium"
  jenkins_disk_size            = 50
  jfrog_instance_type          = "e2-medium"
  jfrog_disk_size              = 50
  jfrog_registry_instance_type = "e2-medium"
  jfrog_registry_disk_size     = 50
  prometheus_instance_type     = "e2-medium"
  prometheus_disk_size         = 50
  db_disk_size                 = 20
  db_instance_type             = "db-f1-micro"
  lb_instance_type             = "e2-medium"
  create_private_ip_address    = false
  enable_secret_manager        = true
  allowed_ips                  = ["0.0.0.0/0"]
  instance_type                = "e2-medium"
  disk_size                    = 50
  gke_num_nodes                = 3
  gke_disk_size                = 20
  app_additional               = "gitea"
  region_additional            = "us-west1"
  create_private_ip_address    = true
  database_subnet_cidr_range   = "10.3.6.0/24"
  database_allowed_ports       = ["5432"]
  database_allowed_source_ranges = ["10.0.0.0/8"]
  
  # variables for load balancer geo module
  lb_geo_subnet_cidr_range     = "10.3.7.0/24"
  lb_geo_allowed_ports         = ["80", "443"]
  lb_geo_allowed_source_ranges = ["0.0.0.0/0"]
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
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

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket = "unique-project-geo-tf-state"
    prefix = "terraform/${path_relative_to_include()}"
  }
}
EOF
}