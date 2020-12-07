resource "aws_iam_instance_profile" "iam_s3_profile" {
  name  = var.name
  role = var.role
}