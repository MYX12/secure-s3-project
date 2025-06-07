Secure Cloud Infrastructure with Terraform & EKS + Helm CI/CD

This project demonstrates how to build an enterprise-ready AWS infrastructure using Terraform, and deploy a Kubernetes-based web application using Amazon EKS and Helm, integrated with GitHub Actions CI/CD.

It covers:
	•	Infrastructure as Code (IaC) with Terraform
	•	AWS EKS cluster provisioning
	•	Helm chart deployment of Nginx
	•	CI/CD pipeline automation via GitHub Actions

⸻————————————————————————————————————————————————————————————————

 Tech Stack
	•	Terraform: Automate VPC, subnet, EC2, EKS provisioning
	•	Amazon EKS: Managed Kubernetes cluster on AWS
	•	Helm: Kubernetes package manager to manage application deployment
	•	GitHub Actions: CI/CD workflow to automate infrastructure and application delivery
	•	AWS Services: EC2, VPC, IAM, S3, CloudWatch, Internet Gateway, Route Tables
_____________________________________________________________________
Project Structure
secure-s3-project/
├── .github/workflows/        # CI/CD workflow definitions
│   ├── terraform.yml
│   └── helm-cicd.yml
├── terraform/                # Terraform state backend
├── network/                  # Terraform modules for networking
├── my-nginx/                 # Helm chart for nginx
│   ├── charts/
│   ├── templates/
│   ├── Chart.yaml
│   └── values.yaml
├── main.tf                   # Root Terraform configuration
├── backend.tf                # Terraform remote state
├── variables.tf              # Variable definitions
├── lock.tf                   # DynamoDB state lock config
├── nginx-deployment.yaml     # Raw manifest (for comparison)
└── README.md

Key Features
 Project 3: Terraform-Based AWS Infrastructure
	•	Custom VPC with public & private subnets (multi-AZ)
	•	Internet Gateway and NAT Gateway routing
	•	EC2 instance provisioning
	•	S3 bucket with default encryption
	•	CloudWatch alarm + SNS integration
	•	EKS Cluster provisioning with proper IAM roles

 Project 4: Kubernetes + Helm + CI/CD Deployment
	•	Helm chart-based nginx web deployment
	•	LoadBalancer service exposing public IP
	•	GitHub Actions CI/CD pipeline:
	•	Validates Terraform code
	•	Installs kubectl and helm
	•	Configures AWS credentials securely
	•	Applies Helm charts to EKS

Screenshot:

![image](https://github.com/user-attachments/assets/f120ed4c-0f27-4058-9f03-57045bdb3220)

![image](https://github.com/user-attachments/assets/19a7259d-f4ba-47af-855e-3a9768508b78)
