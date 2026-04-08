provider "aws" {
  region = var.region
}



# ---------------- NETWORK ----------------
module "network" {
  source = "../../modules/network"
}

# ---------------- ALB ----------------
module "alb" {
  source = "../../modules/alb"

  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
}

# ---------------- COMPUTE ----------------
module "compute" {
  source = "../../modules/compute"

  private_subnets  = module.network.public_subnets
  ami_id           = var.ami_id
  key_name         = var.key_name
  target_group_arn = module.alb.tg_arn
  vpc_id           = module.network.vpc_id
  alb_sg_id        = module.alb.alb_sg_id
}

# ---------------- DATABASE ----------------
module "database" {
  source = "../../modules/database"

  private_subnets = module.network.public_subnets
  db_username      = var.db_username
  db_password      = var.db_password
}