provider "aws" {
 region = "us-west-2"
}

module "payment_rds_cluster" {
  source = "../../modules/data-stores/rds-cluster"
  tags         = var.tags
  prefix       = local.prefix
  project_name = var.project_name
  cluster_name = "PaymentCluster"
  db_login     = data.aws_ssm_parameter.rds_wallet_login.value
  db_password  = data.aws_ssm_parameter.rds_wallet_password.value
  workspace = "test"
}
module "rds_instance_wallet" {
  source         = "../../modules/data-stores/rds-cluster-instance"
  project_name   = var.project_name
  tags           = var.tags
  prefix         = local.prefix
  db_name        = local.db_name
  engine         = module.payment_rds_cluster.engine
  engine_version = module.payment_rds_cluster.engine_version
  cluster_id     = module.payment_rds_cluster.cluster_identifier
  publicly_accessible = true
}