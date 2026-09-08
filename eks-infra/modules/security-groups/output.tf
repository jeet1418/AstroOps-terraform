output "jump_server_sg_id" {
  description = "ID of the Jump Server Security Group"
  value       = aws_security_group.jump_server.id
}

output "eks_cluster_sg_id" {
  description = "ID of the EKS Cluster Security Group"
  value       = aws_security_group.eks_cluster.id
}