output "master_instance_id" {
  description = "ID of the Master EC2 instance"
  value       = aws_instance.master_server.id
}

output "master_instance_public_ip" {
  description = "Public IP address of the Master EC2 instance"
  value       = aws_instance.master_server.public_ip
}

output "worker_1_instance_id" {
  description = "ID of the Worker 1 EC2 instance"
  value       = aws_instance.worker_1_server.id
}

output "worker_1_instance_public_ip" {
  description = "Public IP address of the Worker 1 EC2 instance"
  value       = aws_instance.worker_1_server.public_ip
}

# output "worker_2_instance_id" {
#   description = "ID of the Worker 2 EC2 instance"
#   value       = aws_instance.worker_2_server.id
# }
#
# output "worker_2_instance_public_ip" {
#   description = "Public IP address of the Worker 2 EC2 instance"
#   value       = aws_instance.worker_2_server.public_ip
# }
