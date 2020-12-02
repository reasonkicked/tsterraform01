variable "engine" {
  description = "DB engine"
  type        = string
  default     = "aurora-mysql"
}
variable "engine_version" {
  description = "DB engine version"
  type        = string
  default     = "5.7.mysql_aurora.2.03.2"
}
variable "backup_retention_period" {
  description = "Backup retention period"
  type        = number
  default     = 30
}
variable "preferred_backup_window" {
  description = "Preffered backup time window"
  type        = string
  default     = "04:00-07:00"
}
variable "cluster_name" {
  description = "cluster name"
  type        = string
  default     = "cluster"
}
variable "project_name" {
  description = "cluster name"
  type        = string
  default     = "cluster"
}
variable "workspace" {
  description = "Name of current workspace"
  type        = string
}
variable "tags" {
  description = "A map of tags for all resources"
  type        = map(string)
  default     = {}
}
