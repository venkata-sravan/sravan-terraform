resource "aws_security_group" "tomcat-sg" {
  name = "tomcat-sg"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "tomcat_launch" {
  image_id        = "ami-0c65454b94d1c27f4"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my-sg.id]
  key_name        = "my-kali"
  
  user_data = file("config.sh")

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "all" {}

resource "aws_autoscaling_group" "tomcat_asg" {
  launch_configuration = aws_launch_configuration.tomcat_launch.id
  vpc_zone_identifier = flatten([aws_subnet.private.*.id])
  
  min_size = 0
  max_size = 0
  
  load_balancers    = [aws_elb.tomcat_elb.name]
  health_check_type = "ELB"
  
  tag {
    key                 = "Name"
    value               = "tomcat_asg"
    propagate_at_launch = true
  }
}

resource "aws_elb" "tomcat_elb" {
  name               = "tomcat-elb"
  security_groups    = [aws_security_group.elb.id]
  subnets = aws_subnet.public.*.id

  health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port           = var.elb_port
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }
}

resource "aws_security_group" "elb" {
  name = "elb"
  vpc_id = aws_vpc.my_vpc.id

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTP from anywhere
  ingress {
    from_port   = var.elb_port
    to_port     = var.elb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
