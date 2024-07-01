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
  subnet_cidr_range     = get_env("TF_VAR_database_subnet_cidr_range", "10.3.6.0/24")
  allowed_ports         = jsondecode(get_env("TF_VAR_database_allowed_ports", "[\"5432\"]"))
  allowed_source_ranges = jsondecode(get_env("TF_VAR_database_allowed_source_ranges", "[\"10.0.0.0/8\"]"))
  gke_subnet_cidr       = get_env("TF_VAR_gke_subnet_cidr", "10.20.0.0/24")
  vm_subnet_cidr        = get_env("TF_VAR_vm_subnet_cidr", "10.30.0.0/24")
}

