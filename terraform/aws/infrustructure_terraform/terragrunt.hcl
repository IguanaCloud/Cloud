terraform {
  source = "."
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
    access_key = "${get_env("AWS_ACCESS_KEY_ID","")}"
    secret_key = "${get_env("AWS_SECRET_ACCESS_KEY","")}"
    region = "eu-central-1"
}
EOF
}