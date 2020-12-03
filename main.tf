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

module "vpc1" {
  source = "./modules/network/vpc"
  cidr_vpc = "10.1.0.0/16"
  
}

module "vpc2" {
  source = "./modules/network/vpc"
  cidr_vpc = "10.2.0.0/16"
  
}

module "igw1" {
  source = "./modules/network/igw"
  vpc_id = module.vpc1.vpc_id
} 
module "subnet_public_1" {
  source = "./modules/network/subnet_public"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.1.0/24"  
  subnet_az = "us-west-2a"
}
module "subnet_public_2" {
  source = "./modules/network/subnet_public"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.2.0/24"  
  subnet_az = "us-west-2b"
}
module "subnet_private_1" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.3.0/24"  
  subnet_az = "us-west-2a"
}
module "subnet_private_2" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.4.0/24"  
  subnet_az = "us-west-2b"
}
module "subnet_private_3" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.5.0/24"  
  subnet_az = "us-west-2a"
}
module "subnet_private_4" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.6.0/24"  
  subnet_az = "us-west-2b"
}

module "rtb_public_1" {
  source = "./modules/network/rtb_public"
  subnet_vpc_id = module.vpc1.vpc_id
  vpc_igw_id = module.igw1.igw_id
  Name = "rtb_public_1"
  
}
module "rtb_public_2" {
  source = "./modules/network/rtb_public"
  subnet_vpc_id = module.vpc1.vpc_id
  vpc_igw_id = module.igw1.igw_id
  Name = "rtb_public_2"
  
}
/*
module "network" {
  source = "./global/network"
}
*/

/*
module "rds-test2" {
  source = "./global/rds-db"
   subnet_group_name = "test2"
 
}

*/