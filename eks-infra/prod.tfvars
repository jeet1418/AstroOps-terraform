cluster_name = "astro-cluster"
aws_region = "us-east-1"
kubernetes_version = "1.36"
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
node_groups = {
  "vpro-node-group" = {
    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"
    scaling_config = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
    }
  }
}
bucket_name = "astro-state-bucket"
dynamodb_table = "astro-state-lock"

enable_public_access = false
enable_private_access = true

admin_ip = "103.163.57.189/32"