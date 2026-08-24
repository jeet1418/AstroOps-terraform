provider "aws" {
  region = var.aws_region
}

module "eks" {
    source = "./modules/eks"
    
    cluster_name          = var.cluster_name
    kubernetes_version    = var.kubernetes_version
    subnet_ids            = module.vpc.private_subnet_ids
    node_groups           = var.node_groups
    enable_public_access  = var.enable_public_access
    enable_private_access = var.enable_private_access
    vpc_id = module.vpc.vpc_id
    cluster_security_group_id = module.security_groups.eks_cluster_sg_id
}

module "vpc" {
    source = "./modules/vpc"
    
    cluster_name         = var.cluster_name
    vpc_cidr_block       = var.vpc_cidr_block
    public_subnet_cidrs  = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    availability_zones   = var.availability_zones
}

module "security_groups" {
    source = "./modules/security-groups"
    cluster_name = var.cluster_name
    vpc_id       = module.vpc.vpc_id
}