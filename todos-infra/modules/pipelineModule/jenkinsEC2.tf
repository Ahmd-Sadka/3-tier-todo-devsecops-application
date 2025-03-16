resource "aws_instance" "jenkins" {
    
  ami                         = data.aws_ami.jenkins.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.pipeline.key_name
  iam_instance_profile        = aws_iam_instance_profile.jenkins_ec2_instance_profile.name
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  tags = {
    Name        = "jenkins"
  }

  depends_on = [ aws_key_pair.pipeline ]
}

resource "aws_iam_role" "jenkins_ec2_role" {
  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "jenkins_ec2_cloudwatch_logs" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
resource "aws_iam_instance_profile" "jenkins_ec2_instance_profile" {
  name = "jenkins-ec2-instance-profile"
  role = aws_iam_role.jenkins_ec2_role.name
}