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
  # Module-specific inputs can be added here if needed
}