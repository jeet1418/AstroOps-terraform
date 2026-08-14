<!-- markdownlint-disable-next-line -->
# <img src="https://cdn.simpleicons.org/terraform" alt="Terraform logo" width="45"> AstroOps Terraform

This repository contains the Terraform infrastructure code for provisioning the AWS resources required for the project.

The infrastructure is divided into two main components:

- **Backend** – Creates the Terraform remote state infrastructure.
- **EKS Infrastructure** – Creates the VPC, EKS cluster, and security groups using reusable Terraform modules.

---

## 1. Terraform Backend

The `backend` directory contains Terraform code for creating the AWS resources required to store and manage Terraform state remotely.

### Resources

- **Amazon S3**
  - Stores Terraform state files.
  - Provides centralized and persistent state storage.

- **Amazon DynamoDB**
  - Used for Terraform state locking.
  - Helps prevent multiple Terraform operations from modifying the state simultaneously.

---

## 2. EKS Infrastructure

The `eks-infra` directory contains the Terraform infrastructure required to deploy the Kubernetes environment on AWS.

It uses a **modular Terraform architecture** to keep the infrastructure reusable, organized, and maintainable.

### Components

- **VPC**
  - Creates the AWS networking infrastructure required by EKS.
  - Includes subnets, route tables, Internet Gateway, and NAT Gateway.

- **EKS Cluster**
  - Creates the Amazon EKS Kubernetes cluster.
  - Provides the managed Kubernetes control plane and worker node infrastructure.

- **Security Groups**
  - Controls network traffic between AWS resources.
  - Defines inbound and outbound access rules for the infrastructure.

- **Jump Server Security Group**
  - Controls access to the jump server.
  - Allows administrative access to private AWS resources through the jump server.

## Design Principles

This repository follows several infrastructure-as-code practices:

- **Modular Terraform** – Reusable VPC, EKS, and security-group modules.
- **Remote State** – Terraform state is stored in Amazon S3.
- **State Locking** – DynamoDB is used for state locking.
- **Environment Configuration** – Environment-specific values are maintained in `.tfvars` files.
- **CI/CD Automation** – Terraform operations are executed through Jenkins.
- **Controlled Access** – Administrative access can be routed through a jump server.
- **Separation of Concerns** – Backend infrastructure and EKS infrastructure are maintained separately.