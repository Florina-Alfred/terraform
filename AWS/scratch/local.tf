resource "local_file" "ansible_inventory_list" {
  # content = "${aws_instance.master_server.public_ip}\n${aws_instance.worker_1_server.public_ip}\n${aws_instance.worker_2_server.public_ip}"
  content = <<EOT
[master]
${aws_instance.master_server.public_ip}

[worker]
${aws_instance.worker_1_server.public_ip}
${aws_instance.worker_2_server.public_ip}
  EOT
  filename = "${var.ansible_inventory_path}/generated_inventroy"
}

# resource "local_file" "ansible_inventory_list_test" {
#   content = <<EOT
# %{ for ip in aws_instance.worker[*].public_ip ~}
# server ${ip}
# %{ endfor ~}
#   EOT
#   filename = "${var.ansible_inventory_path}/generated_inventroy_test"
# }
#
