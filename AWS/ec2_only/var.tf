variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "terraform_example"
}

variable "ssh_key" {
  description = "ssh on local computer"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDegRSIoiY/42/xYF6ZY0OzJ/HJmA+6Zu46b2kOPwliPFdDAjkYf1gs7yv9dDZSXYhdJImnRrvAhujeaPqWIzB6+TFO4TYcwunpnKHGwGUrg0sH8P9k5Y6PG4xJyqR+G4dBYfYoykWmtVTu2/teD0f61cZtyxxKQ6/esvFjsrnLJ8bwTC5zn78bzoEITmVe6SZKXQU9EBROZWtuEvZEbDRZ8JLcI6lMRM+H/+NzBVAeAbh8O1i16W4iSKQYioEeeJuO1tFGpjBbu5/0wICdfIJCFuT6CSRLRxYJpHrNGtzEx2KMUjokCRNWmRMELl5Dgte4GIRYA+a228hXFgC4NtlS+RG3C2LP+zTyC9d2RmyRN2RiNznRcGHZZhWwmSiTuPmV7fbI+gv/Erlw5qNyJFztColNJrtuO18bXhsW1j/pOCusp5OikY5wOgiaXM3K2yH/r7XL72j8f31JB1AWMZK2yZTwy0bDeW3ufLAEZv+LICAmuIZG4IjyDrbMiR7VKVs= kutty@legion"
}
