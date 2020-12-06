module "vpc1" {
  source = "./modules/network/vpc"
  cidr_vpc = "10.1.0.0/16"
  
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
  Name-tag = "subnet_public_1"
  
}
module "subnet_public_2" {
  source = "./modules/network/subnet_public"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.2.0/24"  
  subnet_az = "us-west-2b"
  Name-tag = "subnet_public_2"
}
module "subnet_private_1" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.3.0/24"  
  subnet_az = "us-west-2a"
  Name-tag = "subnet_private_1"
}
module "subnet_private_2" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.4.0/24"  
  subnet_az = "us-west-2b"
  Name-tag = "subnet_private_2"
}
module "subnet_private_3" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.5.0/24"  
  subnet_az = "us-west-2a"
  Name-tag = "subnet_private_3"
}
module "subnet_private_4" {
  source = "./modules/network/subnet_private"
  subnet_vpc_id = module.vpc1.vpc_id
  cidr_subnet = "10.1.6.0/24"  
  subnet_az = "us-west-2b"
  Name-tag = "subnet_private_4"
}

module "rtb_public_1" {
  source = "./modules/network/rtb_public"
  vpc_id = module.vpc1.vpc_id
  gateway_id = module.igw1.igw_id
  Name = "rtb_public_1"
  
}
module "rtb_public_2" {
  source = "./modules/network/rtb_public"
  vpc_id = module.vpc1.vpc_id
  gateway_id = module.igw1.igw_id
  Name = "rtb_public_2"
  
}
/*
module "rta_subnet_public_1" {
  source = "./modules/network/rtb_association"
  subnet_id = module.subnet_public_1.public_subnet_id
  route_table_id = module.rtb_public_1.public_rtb_id
}
module "rta_subnet_public_2" {
  source = "./modules/network/rtb_association"
  subnet_id = module.subnet_public_2.public_subnet_id
  route_table_id = module.rtb_public_2.public_rtb_id
}
*/
module "eip_01" {
  source = "./modules/network/eip"
}
module "eip_02" {
  source = "./modules/network/eip"
}
module "nat_gw_01" {
  source = "./modules/network/nat_gw"
  allocation_id = module.eip_01.eip_id
  subnet_id = module.subnet_public_1.public_subnet_id
}
module "nat_gw_02" {
  source = "./modules/network/nat_gw"
  allocation_id = module.eip_02.eip_id
  subnet_id = module.subnet_public_2.public_subnet_id
}
module "nat_gw_rt_01" {
  source = "./modules/network/nat_gw_rt"
  vpc_id = module.vpc1.vpc_id
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = module.nat_gw_01.nat_gw_id
  Name = "nat_gw_rt_01"
}
module "nat_gw_rt_02" {
  source = "./modules/network/nat_gw_rt"
  vpc_id = module.vpc1.vpc_id
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = module.nat_gw_02.nat_gw_id
  Name = "nat_gw_rt_02"
}

module "nat_gw_rt_association_01" {
  source = "./modules/network/nat_gw_rt_association"
  subnet_id = module.subnet_public_1.public_subnet_id
  route_table_id = module.rtb_public_1.public_rtb_id
}
module "nat_gw_rt_association_02" {
  source = "./modules/network/nat_gw_rt_association"
  subnet_id = module.subnet_public_2.public_subnet_id
  route_table_id = module.rtb_public_2.public_rtb_id
}

module "rta_subnet_private_1" {
  source = "./modules/network/rtb_association"
  subnet_id = module.subnet_private_1.private_subnet_id
  route_table_id = module.rtb_public_1.public_rtb_id
}
module "rta_subnet_private_2" {
  source = "./modules/network/rtb_association"
  subnet_id = module.subnet_private_2.private_subnet_id
  route_table_id = module.rtb_public_2.public_rtb_id
}
module "rta_subnet_private_3" {
  source = "./modules/network/rtb_association"
  subnet_id = module.subnet_private_3.private_subnet_id
  route_table_id = module.rtb_public_1.public_rtb_id
}
module "rta_subnet_private_4" {
  source = "./modules/network/rtb_association"
  subnet_id = module.subnet_private_4.private_subnet_id
  route_table_id = module.rtb_public_2.public_rtb_id
}

module "sg_22" {
    source = "./modules/network/security_group"
    name = "sg_22"
    vpc_id = module.vpc1.vpc_id
    sg_from_port = 22
    sg_to_port = 22
}
module "sg_80" {
    source = "./modules/network/security_group"
    name = "sg_80"
    vpc_id = module.vpc1.vpc_id
    sg_from_port = 80
    sg_to_port = 80
}
module "sg_443" {
    source = "./modules/network/security_group"
    name = "sg_443"
    vpc_id = module.vpc1.vpc_id
    sg_from_port = 443
    sg_to_port = 443
}
module "sg_8080" {
    source = "./modules/network/security_group"
    name = "sg_8080"
    vpc_id = module.vpc1.vpc_id
    sg_from_port = 8080
    sg_to_port = 8080
}


module "sg_3306" {
    source = "./modules/network/security_group_nested"
    name = "sg_3306"
    vpc_id = module.vpc1.vpc_id
    sg_from_port = 3306
    sg_to_port = 3306
    
   //module.sg_8080.security_group_sg_8080_id
    security_groups_ids = [
        module.sg_80.security_group_id,
        module.sg_8080.security_group_id
    ]
}
