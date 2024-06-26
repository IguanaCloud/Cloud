include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "."
}

inputs = {
  # If you need any specific inputs for tf_state, add them here
}