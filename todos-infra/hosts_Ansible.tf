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
echo "[Jenkins_EC2]" > ../AnsibleRoles/inventory
echo "${module.pipelineModule.Jenkins_public_ip}" >> ../AnsibleRoles/inventory
echo "" >> ../AnsibleRoles/inventory
echo "[Worker_Nodes_EC2]" >> ../AnsibleRoles/inventory
${join("\n", [for ip in module.eksModule.node_group_ips : "echo '${ip}' >> ../AnsibleRoles/inventory"])}
EOT
  }
}