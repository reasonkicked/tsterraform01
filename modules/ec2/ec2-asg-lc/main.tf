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
data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")

  vars = {
    
  }
}
resource "aws_launch_configuration" "asglc" {
  image_id        = var.instance_ami
  instance_type   = var.instance_type
  security_groups = var.security_groups_for_ec2
  key_name = var.key_pair_for_ec2 //aws_key_pair.ec2key.key_name
  //data.template_file.user_data.rendered
 user_data = <<-EOF
#!/bin/bash

yum update -y && yum install httpd -y && service httpd start && chkconfig httpd on && echo "welcome to 02" >> /var/www/html/index.html
              EOF
  lifecycle {
  create_before_destroy = true
  }
  
}


