########################################
# EC2 Variables
########################################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where EC2 will be launched"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID (not strictly needed but useful for extension)"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID"
  type        = string
}