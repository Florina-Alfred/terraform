resource "local_file" "ansible_inventory_list" {
  content  = <<EOT
---
k3s_cluster:
  children:
    server:
      hosts:
        ${aws_instance.master_1_server.public_ip}:
        ${aws_instance.master_2_server.public_ip}:
        ${aws_instance.master_3_server.public_ip}:
    agent:
      hosts:
        ${aws_instance.worker_1_server.public_ip}:
        ${aws_instance.worker_2_server.public_ip}:
        ${aws_instance.worker_3_server.public_ip}:
        ${aws_instance.worker_4_server.public_ip}:
        ${aws_instance.worker_5_server.public_ip}:

  # Required Vars
  vars:
    ansible_port: 22
    ansible_user: ubuntu
    k3s_version: v1.26.9+k3s1
    token: "mytoken"  # Use ansible vault if you want to keep it secret
    api_endpoint: "{{ hostvars[groups['server'][0]]['ansible_host'] | default(groups['server'][0]) }}"
    extra_server_args: ""
    extra_agent_args: ""

  EOT
  filename = "${var.ansible_inventory_path}/generated_inventroy"
}


# resource "local_file" "ansible_inventory_list" {
#   # content = "${aws_instance.master_1_server.public_ip}\n${aws_instance.worker_1_server.public_ip}\n${aws_instance.worker_2_server.public_ip}"
#   content  = <<EOT
# [servers]
# ${aws_instance.master_1_server.public_ip}
# ${aws_instance.worker_1_server.public_ip}
# ${aws_instance.worker_2_server.public_ip}
#   EOT
#   filename = "${var.ansible_inventory_path}/generated_inventroy"
# }

# resource "local_file" "ansible_inventory_list" {
#   content  = <<EOT
# [master]
# ${aws_instance.master_1_server.public_ip}
#
# [worker]
# ${aws_instance.worker_1_server.public_ip}
# ${aws_instance.worker_2_server.public_ip}
#   EOT
#   filename = "${var.ansible_inventory_path}/generated_inventroy"
# }

# resource "local_file" "ansible_inventory_list_test" {
#   content = <<EOT
# %{ for ip in aws_instance.worker[*].public_ip ~}
# server ${ip}
# %{ endfor ~}
#   EOT
#   filename = "${var.ansible_inventory_path}/generated_inventroy_test"
# }
#
