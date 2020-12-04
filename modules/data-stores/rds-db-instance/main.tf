terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "tsterraform01-s3"
    key            = "terraform_state/terraform.tfstate"
    region         = "us-west-2"

    # Replace this with your DynamoDB table name!
   // dynamodb_table = "terraform-up-and-running-locks"
   // encrypt        = true
  }
}

data "terraform_remote_state" "terraform_state" {
  //workspace = terraform.workspace
  backend   = "s3"
  config = {
    bucket = "tsterraform01-s3"
    key    = "terraform_state/terraform.tfstate"
    region = "us-west-2"
  }
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = var.subnet_group_db_name
  skip_final_snapshot = true
  vpc_security_group_ids = var.security_groups_ids_list
  multi_az = true
}
