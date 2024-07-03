
terraform {
  source = "../../modules/aws_key_pair"
}

include {
  path = find_in_parent_folders()
}
