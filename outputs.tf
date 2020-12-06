/*output "public_instance_ip" {
  value = [aws_instance.tsawslnx01.public_ip]
}
/*output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}*/
/*
output "alb_dns_name" {
  value       = aws_lb.tsalb01.dns_name
  description = "The domain name of the load balancer"
}
output "public_subnet_1" {
  value = module.network.public_subnet_1
}
output "public_subnet_2" {
  value = module.network.public_subnet_2
}
output "dbsg" {
  value = module.network.dbsg
}
*/
output "vpc1_id" {
  value = module.vpc1.vpc_id
}

output "igw_id" {
  value = module.igw1.igw_id
}
output "public_rtb_1_id" {
  value = module.rtb_public_1.public_rtb_id
}
output "public_subnet_1_id" {
  value = module.subnet_public_1.public_subnet_id
}
output "public_rtb_2_id" {
  value = module.rtb_public_2.public_rtb_id
}
output "public_subnet_2_id" {
  value = module.subnet_public_2.public_subnet_id
}
output "private_subnet_1_id" {
  value = module.subnet_private_1.private_subnet_id
}
output "private_subnet_2_id" {
  value = module.subnet_private_2.private_subnet_id
}
output "private_subnet_3_id" {
  value = module.subnet_private_1.private_subnet_id
}
output "private_subnet_4_id" {
  value = module.subnet_private_2.private_subnet_id
}

output "security_group_sg_22_id" {
  value = module.sg_22.security_group_id
}
output "security_group_sg_80_id" {
  value = module.sg_80.security_group_id
}
output "security_group_sg_443_id" {
  value = module.sg_443.security_group_id
}
output "security_group_sg_8080_id" {
  value = module.sg_8080.security_group_id
}
output "security_group_sg_3306_id" {
  value = module.sg_3306.security_group_id
}

output "rds_db_subnet_group_01_id" {
  value = module.rds_db_subnet_group_01.db_subnet_group_id
}

output "ec2_key_pair_name" {
    value = module.ec2_key_pair.key_pair_name
}

output "ec2_asg_lc_1_name" {
  value = module.ec2_asg_lc_1.ec2_asg_lc_name
}

output "alb01_arn" {
  value = module.alb01.alb_arn
}

output "alb_listener_http_01_arn" {
  value = module.alb_listener_http_01.alb_listener_http_arn
}

output "alb_target_group_01_arn" {
  value = module.alb_target_group_01.alb_target_group_arn
}

output "eip_01_id" {
  value = module.eip_01.eip_id
}
output "eip_02_id" {
  value = module.eip_02.eip_id
}
output "nat_gw_01_id" {
  value = module.nat_gw_01.nat_gw_id
}
output "nat_gw_02_id" {
  value = module.nat_gw_02.nat_gw_id
}
output "nat_gw_rt_01_id" {
  value = module.nat_gw_rt_01.nat_gw_rt_id
}
output "nat_gw_rt_02_id" {
  value = module.nat_gw_rt_02.nat_gw_rt_id
}

output "s3_bucket_s3-wp-media-ts_id" {
  value = module.s3-wp-media-ts.s3_bucket_id
}
output "cloudfront_oai_wp_id" {
  value = module.cloudfront_oai_wp.oai_id
}
output "iam_role_s3_full_access_id" {
  value = module.iam_role_s3_full_access.iam_role_s3_full_access_id
}