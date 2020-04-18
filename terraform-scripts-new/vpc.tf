resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  tags= {
    Name = "MyVPC"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags ={
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  count = length(var.subnets_cidr)
  vpc_id = aws_vpc.my_vpc.id
  cidr_block =element(var.subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = true
  tags ={
    Name = "Subnet-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count =length(var.private_subnets_cidr)
  vpc_id = aws_vpc.my_vpc.id
  cidr_block =element(var.private_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  tags= {
    Name = "Subnet-${count.index+1}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =aws_internet_gateway.my_igw.id
  }
  tags= {
    Name = "publicRouteTable"
  }
}

resource "aws_route_table_association" "a" {
  count =length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id,count.index)
  route_table_id = aws_route_table.public_rt.id
}
