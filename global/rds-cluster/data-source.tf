data "aws_ssm_parameter" "rds_wallet" {
  filter {
    name   = "rds_wallet_login"
    values = ["admin"]
  }

  filter {
    name   = "rds_wallet_password"
    values = ["web"]
  }

  most_recent = true
}