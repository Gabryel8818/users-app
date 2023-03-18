resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.users-app.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.users-app.id
  }
}

resource "aws_route_table_association" "public" {
  for_each       = local.context[terraform.workspace].subnets_public
  subnet_id      = aws_subnet.public["${each.key}"].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
