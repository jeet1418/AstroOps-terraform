variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use"
  type        = string
}

variable "node_groups" {
  description = "The configuration for the EKS node groups"
  type        = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones for the EKS cluster"
  type        = list(string)
}

variable "bucket_name" {
  description = "The name of the S3 bucket for storing Terraform state"
  type        = string
}

variable "dynamodb_table" {
  description = "The name of the DynamoDB table for Terraform state locking"
  type        = string
}

variable "enable_public_access" {
  description = "Whether to enable public access for the EKS cluster"
  type        = bool
}

variable "enable_private_access" {
  description = "Whether to enable private access for the EKS cluster"
  type        = bool
}
