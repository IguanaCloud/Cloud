include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "."
  extra_arguments "common_vars" {
    commands = ["apply", "plan", "destroy"]
    arguments = [
      "-var-file=${get_parent_terragrunt_dir()}/workspace_vars/default.tfvars"
    ]
  }
}

inputs = {
  project         = "iguana-dev-env"
  env             = "dev"
  app             = "iguana"
  region          = "us-central1"
  zone            = "us-central1-a"
  gke_num_nodes   = 3
  gke_disk_size   = 20
  app_additional  = "gitea"
  region_additional = "us-west1"
  vpc_network     = "dev-us-central1-iguana-vpc-cluster"
  sub_network     = "dev-us-central1-iguana-subnet-cluster"
}
