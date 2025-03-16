output "Jenkins_instance_id" {
    description = "The ID of the Jenkins EC2 instance"
    value = aws_instance.jenkins.id
}

output "Jenkins_instance_arn" {
    description = "The ARN of the Jenkins EC2 instance"
    value = aws_instance.jenkins.arn
}
output "Jenkins_public_ip" {
    description = "The public IP address of the Jenkins EC2 instance"
    value = aws_instance.jenkins.public_ip
  
}
output "Jenkins_private_ip" {
    description = "The private IP address of the Jenkins EC2 instance"
    value = aws_instance.jenkins.private_ip
  
}

output "key_name" {
  value = aws_key_pair.pipeline.key_name  
}