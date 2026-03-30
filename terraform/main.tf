module "vpc" {
  source = "./modules/vpc"

  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "sg" {
  source = "./modules/security-groups"

  name          = "consul-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = [22, 8000, 8500]
}

module "ec2" {
  source = "./modules/ec2"
  
  instance_type = var.instance_type
  subnet_id     = module.vpc.subnet_id
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name
  sg_id         = module.sg.sg_id
}