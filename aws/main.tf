module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.modules.vpc_cidr
  public_subnet_cidr   = var.modules.public_subnet_cidr
  private_subnet_cidr  = var.modules.private_subnet_cidr
  availability_zone    = var.modules.availability_zone
}

module "alb" {
  source              = "./modules/alb"
  subnets             = [module.vpc.public_subnet_id]
  vpc_id              = module.vpc.vpc_id
  security_group_id   = module.vpc.web_sg_id
}

module "ecs" {
  source              = "./modules/ecs"
  container_image     = var.modules.container_image
  target_group_arn    = module.alb.target_group_arn
  subnets             = [module.vpc.public_subnet_id]
  security_group_id   = module.vpc.web_sg_id
}

module "rds" {
  source             = "./modules/rds"
  subnet_ids         = [module.vpc.private_subnet_id]
  security_group_id  = module.vpc.db_sg_id
  db_username        = var.modules.db_username
  db_password        = var.modules.db_password
}
