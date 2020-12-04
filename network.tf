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

module "rta_subnet_public_1" {
  source = "./modules/network/rtb_association"
  public_subnet_id = module.subnet_public_1.public_subnet_id
  public_rtb_id = module.rtb_public_1.public_rtb_id
}
module "rta_subnet_public_2" {
  source = "./modules/network/rtb_association"
  public_subnet_id = module.subnet_public_2.public_subnet_id
  public_rtb_id = module.rtb_public_2.public_rtb_id
}
module "sg_22" {
    source = "./modules/network/security_group"
    security_group_name = "sg_22"
    subnet_vpc_id = module.vpc1.vpc_id
    sg_from_port = 22
    sg_to_port = 22
}
module "sg_80" {
    source = "./modules/network/security_group"
    security_group_name = "sg_80"
    subnet_vpc_id = module.vpc1.vpc_id
    sg_from_port = 80
    sg_to_port = 80
}
module "sg_8080" {
    source = "./modules/network/security_group"
    security_group_name = "sg_8080"
    subnet_vpc_id = module.vpc1.vpc_id
    sg_from_port = 8080
    sg_to_port = 8080
}

//how to pass module.sg_80.security_group_sg_80_id ???
//"This object does not have an attribute named "security_group_sg_80_id".""
module "sg_3306" {
    source = "./modules/network/security_group_nested"
    security_group_name = "sg_3306"
    subnet_vpc_id = module.vpc1.vpc_id
    sg_from_port = 3306
    sg_to_port = 3306
    
   //module.sg_8080.security_group_sg_8080_id
    security_groups_ids = [
        module.sg_80.security_group_id,
        module.sg_8080.security_group_id
    ]
}
