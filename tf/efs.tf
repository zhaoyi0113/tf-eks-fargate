resource "aws_iam_policy" "efs_csi_driverpolicy" {
  name        = "${var.eks_cluster_name}_efs_csi_driverpolicy"
  path        = "/"
  description = "AmazonEKS_EFS_CSI_Driver_Policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticfilesystem:*",
        ],
        "Resource" : "*"
      },
    ]
  })

  tags = {
    COMPONENT_NAME = var.component_name
  }
}

resource "aws_security_group" "efs_sg" {
  name        = "${var.eks_cluster_name}_efs"
  description = "security group with an inbound rule that allows inbound NFS traffic for your Amazon EFS mount points"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "allows inbound NFS traffic from the CIDR for your cluster VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    COMPONENT_NAME = var.component_name
  }
}

resource "aws_efs_file_system" "efs_file_system" {

  tags = {
    COMPONENT_NAME = var.component_name
  }
}

resource "aws_efs_mount_target" "efs_mount_target_sn1" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "efs_mount_target_sn2" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = module.vpc.private_subnets[1]
  security_groups = [aws_security_group.efs_sg.id]
}
