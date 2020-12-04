provider "aws" {
 region = "us-west-2"
}
resource "aws_s3_bucket" "tsterraform01-s3" {
  bucket = "tsterraform01-s3"

  lifecycle {
    prevent_destroy = false
  }

  versioning {
    enabled = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
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


/*
module "network" {
  source = "./global/network"
}
*/


module "rds_db_subnet_group_01" {
  source = "./modules/data-stores/rds-db-subnet-group"
  subnet_group_name = "rds_db_subnet_group_01"
  subnets_ids_list = [
    module.subnet_private_3.private_subnet_id,
    module.subnet_private_4.private_subnet_id
  ]
}


module "rds-db-instance-01" {
  source = "./modules/data-stores/rds-db-instance"
  security_groups_ids_list = [
    module.sg_3306.security_group_id
  ]
  subnet_group_db_name = module.rds_db_subnet_group_01.db_subnet_group_id
  
}

module "ec2_key_pair" {
  source = "./modules/ec2/ec2-key-pair"
  name_of_key = "ec2_key_pair"
  public_key_path = "~/.ssh/id_rsa.pub"
}

module "ec2_tslnx01" {
  source = "./modules/ec2/ec2-instance"
  instance_ami = "ami-0e472933a1395e172"
  instance_type = "t2.micro"
  subnet_for_ec2 = module.subnet_public_1.public_subnet_id
  key_pair_for_ec2 = module.ec2_key_pair.key_pair_name
  security_groups_for_ec2 = [
    module.sg_80.security_group_id
  ]



  Name-tag = "ec2_tslnx"
  Owner-tag = "tstanislawczyk"
}
