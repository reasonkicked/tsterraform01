output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnets" {
  value = [aws_subnet.subnet_public.id]
}
output "public_route_table_ids" {
  value = [aws_route_table.rtb_public.id]
}
output "public_instance_ip" {
  value = [aws_instance.tsawslnx01.public_ip]
}
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}
