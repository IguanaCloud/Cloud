# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "gcs" {
    bucket = "unique-project-geo-tf-state"
    prefix = "terraform/tf_state"
  }
}
