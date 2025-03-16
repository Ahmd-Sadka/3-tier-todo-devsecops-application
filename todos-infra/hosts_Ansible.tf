resource "null_resource" "generate_inventory" {
  depends_on = [
    module.eksModule.node_group,
    module.pipelineModule.Jenkins_EC2,
  ]

  triggers = {
    jenkins_ip      = module.pipelineModule.Jenkins_public_ip
    worker_node_ips = join(",", module.eksModule.node_group_ips)
  }

  provisioner "local-exec" {
    command = <<EOT
echo "[Jenkins_EC2]" > ../Ansible/my_inventory.ini
echo "${module.pipelineModule.Jenkins_public_ip}" >> ../Ansible_plays/pipeline_cfg/my_inventory.ini
echo "" >> ../Ansible/my_inventory.ini
echo "[Worker_Nodes_EC2]" >> ../Ansible/my_inventory.ini
${join("\n", [for ip in module.eksModule.node_group_ips : "echo '${ip}' >> ../Ansible_plays/pipeline_cfg/my_inventory.ini"])}
EOT
  }
}