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
resource "aws_autoscaling_group" "asg" {
  //depends_on = var.depends_on
  launch_configuration = var.launch_configuration // aws_launch_configuration.tslc01.name
  //target_group_arns =[aws_lb_target_group.tsasg01.arn]

  //availability_zones = ["us-west-2a"]
  vpc_zone_identifier       = var.subnets_ids_list //[aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
  min_size = var.min_size
  max_size = var.max_size
  target_group_arns = var.target_group_arns
  health_check_grace_period = var.health_check_grace_period 

  tag {
    key                 = "Name"
    value               = var.Name-tag
        propagate_at_launch = true
  }
 
}


