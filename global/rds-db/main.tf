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
resource "aws_db_subnet_group" "example" {
  name       = "main"

  subnet_ids = [
    data.terraform_remote_state.terraform_state.outputs.public_subnet_1,
    data.terraform_remote_state.terraform_state.outputs.public_subnet_2
    //aws_subnet.subnet_public_1.id,
    //aws_subnet.subnet_public_2.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.example.name
  skip_final_snapshot = true
  vpc_security_group_ids = [data.terraform_remote_state.terraform_state.outputs.dbsg]
}
