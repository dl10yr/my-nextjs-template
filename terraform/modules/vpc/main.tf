resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-${var.env}-igw"
  }
}

# パブリックサブネット
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.env}-public-subnet-a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.env}-public-subnet-c"
  }
}

# プライベートサブネット
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.project_name}-${var.env}-private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.40.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "${var.project_name}-${var.env}-private-subnet-c"
  }
}

# NATゲートウェイ用Elastic IP
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.env}-nat-eip"
  }
}

# NATゲートウェイ
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name = "${var.project_name}-${var.env}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.gateway]
}

# パブリックルートテーブル
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.env}-public-rt"
  }
}

# プライベートルートテーブル
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.env}-private-rt"
  }
}

# パブリックサブネットのルートテーブル関連付け
resource "aws_route_table_association" "public_route_table_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_c" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_route_table.id
}

# プライベートサブネットのルートテーブル関連付け
resource "aws_route_table_association" "private_route_table_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_table_c" {
  subnet_id      = aws_subnet.private_subnet_c.id
  route_table_id = aws_route_table.private_route_table.id
}
