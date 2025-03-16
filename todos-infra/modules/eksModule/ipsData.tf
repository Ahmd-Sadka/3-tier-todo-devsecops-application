data "aws_instances" "workers_IP" {
  

    filter {
        name   = "tag:eks:nodegroup-name"
        values = [aws_eks_node_group.node_group.node_group_name]
    }

    filter {
        name   = "instance-state-name"
        values = ["running"]
    }

}