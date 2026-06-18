module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_1     = var.public_subnet_1
  public_subnet_2     = var.public_subnet_2
  private_app_subnet  = var.private_app_subnet
  private_data_subnet = var.private_data_subnet

  az1 = var.az1
  az2 = var.az2
}

module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source    = "../../modules/ec2"
  subnet_id = module.vpc.private_app_subnet
  ec2_sg    = module.security.ec2_sg
  ami       = var.ami
}

module "alb" {
  source          = "../../modules/alb"
  public_subnets  = module.vpc.public_subnets
  alb_sg          = module.security.alb_sg
  vpc_id          = module.vpc.vpc_id
  instance_ids    = module.ec2.instance_ids
}

module "rds" {
  source    = "../../modules/rds"
  subnet_id = [module.vpc.private_data_subnet, module.vpc.private_app_subnet]
  rds_sg    = module.security.rds_sg
  username  = var.db_username
  password  = var.db_password
}

module "redis" {
  source    = "../../modules/redis"
  subnet_id = module.vpc.private_data_subnet
  redis_sg  = module.security.redis_sg
}