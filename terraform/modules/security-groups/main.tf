########################################
# Security Group (no inline rules)
########################################

resource "aws_security_group" "this" {
  name        = var.name
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.name
  }
}

########################################
# Ingress Rules (dynamic)
########################################

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for port in var.ingress_ports : tostring(port) => port }

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"

  from_port   = each.value
  to_port     = each.value
  ip_protocol = "tcp"
}

########################################
# Egress Rule (allow all)
########################################

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}