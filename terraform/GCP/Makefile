GEO_ENV ?= dev-01-us-west1-gitea

init:
	terragrunt init
	terragrunt workspace select ${GEO_ENV} || terragrunt workspace new ${GEO_ENV}

plan: init
	terragrunt plan

apply: plan
	terragrunt apply --auto-approve

destroy: plan
	terragrunt destroy --auto-approve
