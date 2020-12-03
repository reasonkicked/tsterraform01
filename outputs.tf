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
output "vpc2_id" {
  value = module.vpc2.vpc_id
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
output "security_group_sg_80_id" {
  value = module.sg_80.security_group_id
}
output "security_group_sg_8080_id" {
  value = module.sg_8080.security_group_id
}
output "security_group_sg_3306_id" {
  value = module.sg_3306.security_group_id
}