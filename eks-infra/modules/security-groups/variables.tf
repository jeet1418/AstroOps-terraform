variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "admin_ip" {
  description = "Public IP allowed to SSH to Jump Server"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}