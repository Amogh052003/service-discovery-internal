########################################
# Security Group Variables
########################################

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "ingress_ports" {
  description = "List of ports to allow inbound traffic"
  type        = list(number)
}