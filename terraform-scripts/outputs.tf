output "elb_IP" {
  value = aws_elb.tomcat_elb.dns_name
}

