resource "aws_security_group" "my-sg" {
 name       =  "my-sg"
 description="my-sg"
 vpc_id     = aws_vpc.my_vpc.id

 dynamic "ingress" {
  for_each= var.my_inbound
  content {
    from_port = ingress.key
    to_port=ingress.key
    protocol="tcp"
    cidr_blocks=ingress.value
  }
}

dynamic "egress" {
  for_each= var.my_outbound
  content {
    from_port = egress.key
    to_port=egress.key
    protocol="-1"
    cidr_blocks=egress.value
  }
}


}
