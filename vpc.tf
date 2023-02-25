resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "users-app"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "users-app"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/25"

  tags = {
    Name = "users-app-private"
  }
}


resource "aws_subnet" "public" {
  for_each          = local.subnets_public
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "users-app-public"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "users-app"
  }
}


resource "aws_route_table_association" "public" {
  for_each       = local.subnets_public
  subnet_id      = aws_subnet.public["${each.key}"].id
  route_table_id = aws_route_table.public.id
}
