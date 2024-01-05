variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "terraform_example"
}

variable "ssh_key" {
  description = "ssh on local computer"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBpcGmCeAI3dzTHegsN3yH4oJ+x3TfjB3iZTC4F5Pcu user@server"
}

variable "ssh_port" {
  description = "ssh key for local machine"
  type        = number
  default     = 22
}

variable "wg_port" {
  description = "The port the wg server will use for tcp requests"
  type        = number
  default     = 51821
}

variable "kubectl_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 6443
}
