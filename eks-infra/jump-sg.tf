resource "aws_security_group" "jump_server_sg" {
  name        = "jump-server-sg"
  description = "Security group for Jump Server"
  vpc_id      = module.vpc.vpc_id

  # Allow SSH only from your laptop/public IP
  ingress {
    description = "SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["103.163.57.189/32"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jump-server-sg"
  }
}