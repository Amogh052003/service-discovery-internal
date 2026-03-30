############################
# EC2 Outputs
############################

# output "ec2_public_ip" {
#   description = "Public IP of the EC2 instance"
#   value       = module.ec2.public_ip
# }

############################
# VPC Outputs (optional but useful)
############################

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = module.vpc.subnet_id
}
output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = module.ec2.public_ip
}