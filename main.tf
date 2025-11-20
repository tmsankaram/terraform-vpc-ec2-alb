provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnets[0]
}

module "alb" {
  source         = "./modules/alb"
  public_subnets = module.vpc.public_subnets
  vpc_id         = module.vpc.vpc_id
  instance_id    = module.ec2.instance_id
}

output "alb_dns" {
  value = module.alb.alb_dns
}
