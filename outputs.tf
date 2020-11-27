output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnets" {
  value = [aws_subnet.subnet_public_1.id]
}
output "public_route_table_ids" {
  value = [aws_route_table.rtb_public_1.id]
}
output "public_instance_ip" {
  value = [aws_instance.tsawslnx01.public_ip]
}
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}
output "alb_dns_name" {
  value       = aws_lb.tsalb01.dns_name
  description = "The domain name of the load balancer"
}