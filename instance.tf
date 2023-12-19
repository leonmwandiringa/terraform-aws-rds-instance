resource "aws_db_instance" "default" {
  identifier            = var.database_identifier
  db_name                  = var.database_name
  username              = var.database_identifier
  password              = var.database_password
  port                  = var.database_port
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = var.storage_encrypted
  kms_key_id            = var.kms_key_arn

  vpc_security_group_ids = var.security_group_ids

  db_subnet_group_name        = aws_db_subnet_group.default.name
  multi_az                    = var.multi_az
  storage_type                = var.storage_type
  iops                        = var.storage_type == "io1" ? var.iops : null
  publicly_accessible         = var.publicly_accessible
  snapshot_identifier         = var.snapshot_identifier
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  skip_final_snapshot         = var.skip_final_snapshot
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  
  deletion_protection         = var.deletion_protection
  final_snapshot_identifier   = var.final_snapshot_identifier == null ? var.final_snapshot_identifier : "${var.global_tags.Name}-db-snapshot-${lower(join("-", split(":", timestamp())))}"

  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  tags                        = merge(
    var.global_tags,
    {
      Name = "${var.global_tags.Name} Instance DB"
    }
  )
}
