variable "master_1_instance_name" {
  description = "Value of the Name tag for the EC2 master instance"
  type        = string
  default     = "master_1_instance"
}

variable "master_2_instance_name" {
  description = "Value of the Name tag for the EC2 master instance"
  type        = string
  default     = "master_2_instance"
}

variable "master_3_instance_name" {
  description = "Value of the Name tag for the EC2 master instance"
  type        = string
  default     = "master_3_instance"
}

variable "worker_1_instance_name" {
  description = "Value of the Name tag for the EC2 worker 1 instance"
  type        = string
  default     = "worker_1_instance"
}

variable "worker_2_instance_name" {
  description = "Value of the Name tag for the EC2 worker_2_instance"
  type        = string
  default     = "worker_2_instance"
}

variable "worker_3_instance_name" {
  description = "Value of the Name tag for the EC2 worker_3_instance"
  type        = string
  default     = "worker_3_instance"
}

variable "worker_4_instance_name" {
  description = "Value of the Name tag for the EC2 worker_4_instance"
  type        = string
  default     = "worker_4_instance"
}

variable "worker_5_instance_name" {
  description = "Value of the Name tag for the EC2 worker_5_instance"
  type        = string
  default     = "worker_5_instance"
}

variable "ssh_key" {
  description = "ssh on local computer"
  type        = string
  # default     = file("/home/user/.ssh/id_ed25519.pub")
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBpcGmCeAI3dzTHegsN3yH4oJ+x3TfjB3iZTC4F5Pcu user@server"
}

variable "ssh_port" {
  description = "ssh key for local machine"
  type        = number
  default     = 22
}

variable "kubectl_port" {
  description = "The port kubectl will use for controlling the cluster"
  type        = number
  default     = 6443
}

variable "master_communication_1_port" {
  description = "The port kubectl will use for controlling the cluster"
  type        = number
  default     = 2379
}

variable "master_communication_2_port" {
  description = "The port kubectl will use for controlling the cluster"
  type        = number
  default     = 2380
}

variable "kubelet_metrics_port" {
  description = "The port the wg server will use for tcp requests"
  type        = number
  default     = 10250
}

variable "wg_port" {
  description = "The port the wg server will use for tcp requests"
  type        = number
  default     = 51821
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "ansible_inventory_path" {
  description = "Path to save the inventory list"
  type        = string
  default     = "/home/user/code/ansible/inventory/"
}
