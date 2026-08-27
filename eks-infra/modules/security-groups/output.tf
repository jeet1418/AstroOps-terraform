output "jump_server_sg_id" {
  description = "Jump Server security group ID"
  value       = aws_security_group.jump_server_sg.id
}

output "eks_cluster_sg_id" {
  description = "EKS cluster security group ID"
  value       = aws_security_group.eks_cluster_sg.id
}