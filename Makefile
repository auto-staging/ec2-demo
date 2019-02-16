auto-staging-init: terraform-vpc-init terraform-alb-init terraform-ec2-init terraform-build-init

auto-staging-apply: terraform-vpc-apply terraform-alb-apply terraform-ec2-apply terraform-build-apply

auto-staging-destroy: terraform-build-destroy terraform-ec2-destroy terraform-alb-destroy terraform-vpc-destroy

setup-environment:
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && mv ${GOPATH}/bin/dep /usr/bin/dep

terraform-alb-init:
	cd terraform/alb && \
	terraform init

terraform-alb-apply:
	cd terraform/alb && \
	terraform workspace new ${TF_VAR_branch} || true && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform apply --auto-approve

terraform-alb-destroy:
	cd terraform/alb && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform destroy --auto-approve

terraform-ec2-init:
	cd terraform/ec2 && \
	terraform init

terraform-ec2-apply:
	cd terraform/ec2 && \
	terraform workspace new ${TF_VAR_branch} || true && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform apply --auto-approve

terraform-ec2-destroy:
	cd terraform/ec2 && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform destroy --auto-approve

terraform-vpc-init:
	cd terraform/vpc && \
	terraform init

terraform-vpc-apply:
	cd terraform/vpc && \
	terraform workspace new ${TF_VAR_branch} || true && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform apply --auto-approve

terraform-vpc-destroy:
	cd terraform/vpc && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform destroy --auto-approve

terraform-build-init:
	cd terraform/build && \
	terraform init

terraform-build-apply:
	cd terraform/build && \
	terraform workspace new ${TF_VAR_branch} || true && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform apply --auto-approve

terraform-build-destroy:
	cd terraform/build && \
	terraform workspace select ${TF_VAR_branch} && \
	terraform destroy --auto-approve


prepare:
	dep ensure -v

build: prepare
		go build -o bin/auto-staging-ec2-demo
