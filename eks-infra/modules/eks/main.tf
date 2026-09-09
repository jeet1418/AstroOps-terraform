resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "main" {
  name = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.kubernetes_version

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = false
  }

  vpc_config {
    security_group_ids = var.eks_security_group_ids
    subnet_ids = var.subnet_ids
    endpoint_public_access = var.enable_public_access
    endpoint_private_access = var.enable_private_access

  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}

data "aws_iam_role" "jump_server" {
  name = "JumpServerRole"
}

resource "aws_eks_access_entry" "jump_server" {
  cluster_name  = var.cluster_name
  principal_arn = data.aws_iam_role.jump_server.arn
  type          = "STANDARD"

  depends_on = [
    aws_eks_cluster.main
  ]
}

resource "aws_eks_access_policy_association" "jump_server" {
  cluster_name  = var.cluster_name
  principal_arn = data.aws_iam_role.jump_server.arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [
    aws_eks_access_entry.jump_server
  ]
}

resource "aws_iam_role" "node" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_policy" {

  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ])
  policy_arn = each.value
  role       = aws_iam_role.node.name
}

resource "aws_eks_node_group" "main" {

  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.subnet_ids

  instance_types = each.value.instance_types
  capacity_type = each.value.capacity_type

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  

  depends_on = [
    aws_iam_role_policy_attachment.node_policy
  ]
}