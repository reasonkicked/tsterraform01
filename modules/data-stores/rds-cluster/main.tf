resource "aws_rds_cluster" "cluster" {
  cluster_identifier      = "${var.prefix}-rds-cluster"
  database_name           = var.cluster_name
  engine                  = var.engine
  engine_version          = var.engine_version
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  master_username = var.db_login
  master_password = var.db_password
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.prefix}-final-snapshot"
}



