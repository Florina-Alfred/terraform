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

