resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier          = "${var.prefix}-${var.db_name}"
  cluster_identifier  = var.cluster_id
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_type
  publicly_accessible = var.publicly_accessible
}