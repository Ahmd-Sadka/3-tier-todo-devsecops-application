
output "eks_cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
  # The endpoint URL for the EKS cluster.
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
  # The certificate authority data for the EKS cluster.
}

output "eks_cluster_name" {
  value = aws_eks_cluster.cluster.name
  # The name of the EKS cluster.
}

output "node_group_ips" {
  value = data.aws_instances.workers_IP.public_ips
}

output "ebs_csi_role_arn" {
  value = aws_iam_role.ebs_csi.arn
  # The ARN of the IAM role for the EBS CSI driver. 
}

output "aws_load_balancer_controller_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}