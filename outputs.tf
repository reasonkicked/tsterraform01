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
}*/
output "public_subnet_1" {
  value = module.network.public_subnet_1
}
output "public_subnet_2" {
  value = module.network.public_subnet_2
}
output "dbsg" {
  value = module.network.dbsg
}