provider "aws" {
  region = local.region
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "my-nextjs-template-tfstate"
    key    = "my-nextjs-template-dev-tfstate.tfstate"
    region = "ap-northeast-1"
  }
}

module "vpc" {
  source       = "../../modules/vpc"
  region       = local.region
  project_name = local.project_name
  env          = local.env
}

module "alb" {
  source             = "../../modules/alb"
  project_name       = local.project_name
  env                = local.env
  region             = local.region
  vpc_id             = module.vpc.vpc_id
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_c_id = module.vpc.public_subnet_c_id
}

module "ecs" {
  source                                                 = "../../modules/ecs"
  project_name                                           = local.project_name
  env                                                    = local.env
  fargate_cpu                                            = 256 // MB
  fargate_memory                                         = 512 // MB
  ecr_repo_url                                           = "${module.ci.ecr_repository_url}:latest"
  vpc_id                                                 = module.vpc.vpc_id
  private_subnet_a_id                                    = module.vpc.private_subnet_a_id
  private_subnet_c_id                                    = module.vpc.private_subnet_c_id
  public_subnet_a_id                                     = module.vpc.public_subnet_a_id
  public_subnet_c_id                                     = module.vpc.public_subnet_c_id
  aws_lb_target_group_alb_arn                            = module.alb.aws_lb_target_group_alb_arn
  aws_security_group_alb_id                              = module.alb.aws_security_group_alb_id
  ssm_parameter_access_policy_arn                        = module.ssm.ssm_parameter_policy_arn
  aws_ssm_parameter_env_hoge_arn                         = module.ssm.ssm_parameter_env_hoge_arn
  aws_ssm_parameter_env_database_url_arn                 = module.ssm.ssm_parameter_env_database_url_arn
  aws_ssm_parameter_env_firebase_private_key_arn         = module.ssm.ssm_parameter_env_firebase_private_key_arn
  aws_ssm_parameter_env_firebase_client_email_arn        = module.ssm.ssm_parameter_env_firebase_client_email_arn
  aws_ssm_parameter_env_firebase_project_id_arn          = module.ssm.ssm_parameter_env_firebase_project_id_arn
  aws_ssm_parameter_env_firebase_api_key_arn             = module.ssm.ssm_parameter_env_firebase_api_key_arn
  aws_ssm_parameter_env_firebase_auth_domain_arn         = module.ssm.ssm_parameter_env_firebase_auth_domain_arn
  aws_ssm_parameter_env_firebase_storage_bucket_arn      = module.ssm.ssm_parameter_env_firebase_storage_bucket_arn
  aws_ssm_parameter_env_firebase_messaging_sender_id_arn = module.ssm.ssm_parameter_env_firebase_messaging_sender_id_arn
  aws_ssm_parameter_env_firebase_app_id_arn              = module.ssm.ssm_parameter_env_firebase_app_id_arn
}

module "domain" {
  source               = "../../modules/domain"
  project_name         = local.project_name
  env                  = local.env
  domain               = local.domain
  alb_dns_name         = module.alb.dns_name
  alb_zone_id          = module.alb.zone_id
  alb_arn              = module.alb.alb_arn
  alb_target_group_arn = module.alb.aws_lb_target_group_alb_arn

  providers = {
    aws          = aws
    aws.virginia = aws.virginia
  }
}

module "cloud_front" {
  source              = "../../modules/cloud_front"
  project_name        = local.project_name
  env                 = local.env
  domain              = local.domain
  alb_name            = module.alb.alb_name
  route53_record_fqdn = module.domain.route53_record_fqdn
  route53_zone_id     = module.domain.route53_zone_id
  virginia_cert_arn   = module.domain.virginia_cert_arn
}

module "ci" {
  source                          = "../../modules/ci"
  project_name                    = local.project_name
  env                             = local.env
  full_repository_id              = local.full_repository_id
  ssm_parameter_access_policy_arn = module.ssm.ssm_parameter_policy_arn
}

module "ssm" {
  source                           = "../../modules/ssm"
  project_name                     = local.project_name
  env                              = local.env
  region                           = local.region
  env_hoge                         = local.env_hoge
  ecr_repository_name              = module.ci.ecr_repository_name
  docker_user                      = local.docker_user
  docker_token                     = local.docker_token
  env_database_url                 = local.env_database_url
  env_firebase_private_key         = local.env_firebase_private_key
  env_firebase_client_email        = local.env_firebase_client_email
  env_firebase_project_id          = local.env_firebase_project_id
  env_firebase_api_key             = local.env_firebase_api_key
  env_firebase_auth_domain         = local.env_firebase_auth_domain
  env_firebase_storage_bucket      = local.env_firebase_storage_bucket
  env_firebase_messaging_sender_id = local.env_firebase_messaging_sender_id
  env_firebase_app_id              = local.env_firebase_app_id
}
