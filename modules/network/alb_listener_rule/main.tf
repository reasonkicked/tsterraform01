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
resource "aws_lb_listener_rule" "tsasg01" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type             = var.type
    target_group_arn = var.target_group_arn
  }
 
  condition {
      path_pattern {
      values = ["/index.html*"]
    }
    
 }

}