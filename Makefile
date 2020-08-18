
build-base-image:
	docker build -t nx-terraform-docker:0.0.1  -f Dockerfile .

build-runner-image:
	docker build --rm -t nx-terraform-runner:0.0.1 -f ./terraform/Dockerfile ./terraform

run-terraform:
	@echo "Running command $(CMD)"
	docker run --rm -v output:output --env-file ./env.list nx-terraform-runner:0.0.1 $(CMD)

terraform-plan:
	docker run --rm -v ${PWD}/terraform/output:/usr/local/terraform/output --env-file ./env.list nx-terraform-runner:0.0.1 plan -out=output/tfplan -state=output/terraform.tfstate

terraform-show:
	docker run --rm -v ${PWD}/terraform/output:/usr/local/terraform/output --env-file ./env.list nx-terraform-runner:0.0.1 show output/tfplan

terraform-apply:
	docker run --rm -v ${PWD}/terraform/output:/usr/local/terraform/output --env-file ./env.list nx-terraform-runner:0.0.1 apply -auto-approve -state-out=output/terraform.tfstate -state=output/terraform.tfstate "output/tfplan"

terraform-plan-destroy:
	docker run --rm -v ${PWD}/terraform/output:/usr/local/terraform/output --env-file ./env.list nx-terraform-runner:0.0.1 plan -destroy -out=output/tfplan -state=output/terraform.tfstate

terraform-destroy:
	docker run --rm -v ${PWD}/terraform/output:/usr/local/terraform/output --env-file ./env.list nx-terraform-runner:0.0.1 destroy -auto-approve -state=output/terraform.tfstate

