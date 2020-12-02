



/*


resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "tsawslnx01" {
  ami           = var.instance_ami
  instance_type = var.instance_type

    user_data = <<-EOF
#!/bin/bash

yum update -y && yum install httpd -y && service httpd start && chkconfig httpd on && echo "welcome to 1" >> /var/www/html/index.html
EOF

  subnet_id = aws_subnet.subnet_public_1.id
  vpc_security_group_ids = [aws_security_group.sg_22.id, aws_security_group.sg_8080.id, aws_security_group.sg_80.id]
  key_name = aws_key_pair.ec2key.key_name
 tags = {
  Environment = var.environment_tag
  Name = "tsawslnx01"
  Owner = "tstanislawczyk"
 }
}

resource "aws_instance" "tsawslnx02" {
  ami           = var.instance_ami
  instance_type = var.instance_type

    user_data = <<-EOF
#!/bin/bash

yum update -y && yum install httpd -y && service httpd start && chkconfig httpd on && echo "welcome 02" >> /var/www/html/index.html
EOF

  subnet_id = aws_subnet.subnet_public_2.id
  vpc_security_group_ids = [aws_security_group.sg_22.id, aws_security_group.sg_8080.id, aws_security_group.sg_80.id]
  key_name = aws_key_pair.ec2key.key_name
 tags = {
  Environment = var.environment_tag
  Name = "tsawslnx02"
  Owner = "tstanislawczyk"
 }
}

resource "aws_launch_configuration" "tslc01" {
  image_id        = var.instance_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg_22.id, aws_security_group.sg_8080.id, aws_security_group.sg_80.id]

  user_data = <<-EOF
#!/bin/bash

yum update -y && yum install httpd -y && service httpd start && chkconfig httpd on && echo "welcome to 02" >> /var/www/html/index.html
              EOF
  lifecycle {
  create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "tsasg01" {
  launch_configuration = aws_launch_configuration.tslc01.name
  target_group_arns =[aws_lb_target_group.tsasg01.arn]

  //availability_zones = ["us-west-2a"]
  vpc_zone_identifier       = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
  min_size = 4
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
        propagate_at_launch = true
  }
 
}

resource "aws_elb" "tsclb01" {
  name               = "tsclb01"
  //availability_zones = ["us-west-2a", "us-west-2b"]
  subnets            = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
  security_groups    = [aws_security_group.sgalb_80.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }
  instances                   = [aws_instance.tsawslnx01.id, aws_instance.tsawslnx02.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "tsclb01"
  }
}

resource "aws_lb" "tsalb01" {
  name               = "tsalb01"
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
  security_groups    = [aws_security_group.sgalb_80.id]
}

resource "aws_lb_target_group" "tsasg01" {
  name     = "terraform-asg-example"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tsalb01.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}
resource "aws_lb_listener_rule" "tsasg01" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100


  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tsasg01.arn
  }


  
  condition {
      path_pattern {
      values = ["/index.html*"]
    }
    /*field  = "path-pattern"
    values = ["index.html"]*/
 /* }

}*/