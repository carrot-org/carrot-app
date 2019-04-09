plan:
	cd terraform && terraform init && terraform plan -input=false
apply:
	cd terraform && terraform init && terraform apply -input=false -auto-approve
