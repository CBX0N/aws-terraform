provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source      = "./modules/aws_node/networking"
  environment = var.environment
}

module "auth" {
  source        = "./modules/aws_node/auth"
  key_name      = var.key_name
  identity_file = var.identity_file
  environment   = var.environment
}

module "compute" {
  source            = "./modules/aws_node/compute"
  identity_file     = var.identity_file
  environment       = var.environment
  key_pair_id       = module.auth.keypair_id
  security_group_id = module.networking.security_group_id
  public_subnet_id  = module.networking.public_subnet_id
}