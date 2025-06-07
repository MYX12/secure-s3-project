# Secure Cloud Infrastructure with Terraform & EKS + Helm CI/CD

This project demonstrates how to build an enterprise-ready AWS infrastructure using Terraform, and deploy a Kubernetes-based web application using Amazon EKS and Helm, integrated with GitHub Actions CI/CD.

## Project Objectives

- Provision Infrastructure as Code (IaC) with Terraform
- Set up an EKS cluster with proper IAM roles and security controls
- Deploy Nginx via Helm Charts on the EKS cluster
- Automate Helm-based Kubernetes deployment with GitHub Actions CI/CD pipeline

---

## Tech Stack

- **Terraform**: Automate VPC, subnet, EC2, S3, IAM, CloudWatch, and EKS provisioning  
- **Amazon EKS**: Managed Kubernetes cluster on AWS  
- **Helm**: Kubernetes package manager for app deployments  
- **GitHub Actions**: CI/CD workflow to automate infrastructure and application delivery  
- **AWS Services**: VPC, IAM, EC2, EKS, S3, DynamoDB, Internet Gateway, Route Tables  

---

## Project Structure

<pre>
```text
secure-s3-project/
├── .github/workflows/        # CI/CD workflow definitions
│   ├── terraform.yml         # Terraform validation & plan
│   └── helm-cicd.yaml        # Helm-based Kubernetes deployment
├── terraform/                # Terraform state backend (S3 + DynamoDB)
├── network/                  # Terraform modules: VPC, subnet, route tables, SG, EC2, EKS
├── my-nginx/                 # Helm chart for nginx deployment
│   ├── charts/
│   ├── templates/
│   ├── Chart.yaml
│   └── values.yaml
├── main.tf                   # Root Terraform configuration
├── backend.tf                # Terraform backend config (S3 & DynamoDB)
├── variables.tf              # Centralized input variables
├── lock.tf                   # DynamoDB lock for Terraform state
├── s3.tf                     # Secure encrypted S3 bucket configuration
├── nginx-deployment.yaml     # Kubernetes manifest (for comparison use)
└── README.md

</pre>
---

###  CI/CD Pipelines (GitHub Actions)

#### 1. `terraform.yml`

Triggers on `push` → runs:

- `terraform init`
- `terraform validate`
- `terraform plan`

#### 2. `helm-cicd.yaml`

Triggers on `push` → runs:

- Set up `kubectl` and `helm`
- Configure AWS credentials
- `aws eks update-kubeconfig`
- `helm upgrade --install my-nginx ./my-nginx/`

---

### 📸 Screenshots

- `kubectl get nodes` showing healthy worker nodes
  ![image](https://github.com/user-attachments/assets/7ac1e403-1eea-432b-9044-c8d6072f3b12)

- `kubectl get svc` showing Nginx `LoadBalancer` `EXTERNAL-IP`
![image](https://github.com/user-attachments/assets/dc77fddf-d36c-43db-85ef-ee973389b77f)

- GitHub Actions CI/CD run screenshot with success
![image](https://github.com/user-attachments/assets/14184541-cf34-46a1-8442-f5d1b85ce7a7)
