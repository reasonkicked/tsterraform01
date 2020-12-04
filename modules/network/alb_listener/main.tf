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
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol

  # By default, return a simple 404 page
  default_action {
    type = var.type

    fixed_response {
      content_type = var.content_type
      message_body = var.message_body
      status_code  = var.status_code
    }
  }
}