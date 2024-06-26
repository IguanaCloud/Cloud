# File: C:/Users/anton/Desktop/geocity-main/terraform/modules/<module_name>/terragrunt.hcl

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
}