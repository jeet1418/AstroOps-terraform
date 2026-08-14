output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "jump_server_sg_id" {
  description = "Jump Server security group ID"
  value       = module.security_groups.jump_server_sg_id
}

output "eks_cluster_sg_id" {
  description = "EKS cluster security group ID"
  value       = module.security_groups.eks_cluster_sg_id
}

