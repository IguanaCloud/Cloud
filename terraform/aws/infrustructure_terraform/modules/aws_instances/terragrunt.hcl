include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", "../aws_key_pair"]
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "aws_key_pair" {
  config_path = "../aws_key_pair"
}

inputs = {
  subnet_id = dependency.vpc.outputs.public_subnet_1
  key_pair  = dependency.aws_key_pair.outputs.key_pair
}