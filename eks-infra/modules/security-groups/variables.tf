variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}