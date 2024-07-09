GEO_ENV ?= dev-01-us-west1-gitea

init:
	terraform init
	terraform workspace select ${GEO_ENV} || terraform workspace new ${GEO_ENV}

plan: init
	terraform plan

apply: plan
	terraform apply --auto-approve

destroy: plan
	terraform destroy --auto-approve
