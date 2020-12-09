resource "aws_eip" "eip" {
 vpc = true  
 instance = var.instance
}