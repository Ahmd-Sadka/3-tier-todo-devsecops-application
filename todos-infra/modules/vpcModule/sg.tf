resource "aws_security_group" "sg" {
    name        = "${var.project_name}-sg"
    vpc_id      = aws_vpc.main.id
    description = "Allow all traffic"



    tags = {
        Name = "${var.project_name}-sg"
    }
}


resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  depends_on = [ aws_security_group.sg ]
  lifecycle {
    create_before_destroy = true
  }
}
