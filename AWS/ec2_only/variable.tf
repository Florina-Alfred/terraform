variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "master_1_instance"
}

# variable "ssh_key" {
#   description = "ssh on local computer"
#   type        = string
#   default     = "ssh-x xxx user@server"
# }

variable "ssh_port" {
  description = "ssh key for local machine"
  type        = number
  default     = 22
}

variable "wg_port" {
  description = "Port for WG server requests"
  type        = number
  default     = 51821
}

variable "kubectl_port" {
  description = "Port for kubectl requests"
  type        = number
  default     = 6443
}

variable "http_port" {
  description = "Port for HTTP access"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "Port for HTTPS access"
  type        = number
  default     = 443
}

variable "lb_http_port" {
  description = "Port for HTTP access (load-balancer/Traefik)"
  type        = number
  default     = 8000
}

variable "lb_https_port" {
  description = "Port for HTTPS access (load-balancer/Traefik)"
  type        = number
  default     = 8443
}

variable "lb_metrics_port" {
  description = "Port for LB metrics access"
  type        = number
  default     = 9100
}

variable "lb_traefik_port" {
  description = "Port for accessing Traefik dashboard"
  type        = number
  default     = 9000
}

variable "tester" {
  description = "tester"
  type        = number
  default     = 1232
}

