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
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnets_ids_list
  /*
  subnet_ids = [
    data.terraform_remote_state.terraform_state.outputs.public_subnet_1_id,
    data.terraform_remote_state.terraform_state.outputs.public_subnet_2_id
    //aws_subnet.subnet_public_1.id,
    //aws_subnet.subnet_public_2.id
  ]
*/
  tags = {
    Name = "My DB subnet group"
  }
}

