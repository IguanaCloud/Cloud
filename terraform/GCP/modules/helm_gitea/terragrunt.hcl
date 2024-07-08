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
  username              = get_env("TF_VAR_username", "")
  password              = get_env("TF_VAR_password", "")
  mail                  = get_env("TF_VAR_mail", "")
  registry_url          = get_env("TF_VAR_registry_url", "")
  helm_repo             = get_env("TF_VAR_helm_repo", "")
  helm_chart            = get_env("TF_VAR_helm_chart", "")
  registry_domain       = get_env("TF_VAR_registry_domain", "")
}