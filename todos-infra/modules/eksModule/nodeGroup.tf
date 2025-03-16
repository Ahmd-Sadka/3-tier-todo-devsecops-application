resource "aws_eks_node_group" "node_group" {
    cluster_name    = aws_eks_cluster.cluster.name
    node_group_name = "node_group"
    node_role_arn   = aws_iam_role.eks_node_role.arn
    subnet_ids      = var.subnet_ids
    instance_types  = ["t3.medium"]
    
    capacity_type  = "SPOT"
    disk_size      = 20

    remote_access {
        source_security_group_ids = [var.security_group_id]
        ec2_ssh_key               = var.key
    }

    scaling_config {
        desired_size = 2
        max_size     = 2
        min_size     = 2
    }

    depends_on = [
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
        aws_iam_role_policy_attachment.awsloadbalancercontroller,
        aws_iam_role_policy_attachment.AmazonEBSCSI,
    ]    

    tags = {
        Name = "node_group"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_node_group" {
  security_group_id = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id 
  cidr_ipv4         = "0.0.0.0/0"  
  ip_protocol       = "-1"  
}
