# Create VPC
resource "aws_vpc" "aws_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(var.tags, {
    Name = "ffng-vpc-01"
  })
}

resource "aws_main_route_table_association" "main_route_table" {
  vpc_id         = aws_vpc.aws_vpc.id
  route_table_id = aws_route_table.public.id
}

# Create public subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.public_subnet[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(var.tags, {
    Name = "ffng-public-subnet0${count.index + 1}"
  })
}

# Create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "ffng-route-public-01"
  })
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create network ACL for public subnets
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.aws_vpc.id
  subnet_ids = aws_subnet.public[*].id

  tags = merge(var.tags, {
    Name = "ffng-public-nacl"
  })
}
# Create Public Network ACL rules
resource "aws_network_acl_rule" "public_inbound" {

  network_acl_id = aws_network_acl.public.id

  egress          = false
  rule_number     = var.public_inbound_acl_rules["rule_number"]
  rule_action     = var.public_inbound_acl_rules["rule_action"]
  from_port       = lookup(var.public_inbound_acl_rules, "from_port", null)
  to_port         = lookup(var.public_inbound_acl_rules, "to_port", null)
  protocol        = var.public_inbound_acl_rules["protocol"]
  cidr_block      = lookup(var.public_inbound_acl_rules, "cidr_block", null)
}

resource "aws_network_acl_rule" "public_outbound" {

  network_acl_id = aws_network_acl.public.id

  egress          = true
  rule_number     = var.public_outbound_acl_rules["rule_number"]
  rule_action     = var.public_outbound_acl_rules["rule_action"]
  from_port       = lookup(var.public_outbound_acl_rules, "from_port", null)
  to_port         = lookup(var.public_outbound_acl_rules, "to_port", null)
  protocol        = var.public_outbound_acl_rules["protocol"]
  cidr_block      = lookup(var.public_outbound_acl_rules, "cidr_block", null)
}

# Create private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.private_subnet[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(var.tags, {
    Name = "ffng-private-subnet0${count.index + 1}"
  })
}

# Create private subnet route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(var.tags, {
    Name = "ffng-route-private-01"
  })
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Create network acl for private subnets
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.aws_vpc.id
  subnet_ids = aws_subnet.private[*].id

  tags = merge(var.tags, {
    Name = "ffng-private-nacl"
  })
} 

# Create Network acl rules for private subnet
resource "aws_network_acl_rule" "private_inbound" {

  network_acl_id = aws_network_acl.private.id

  egress          = false
  rule_number     = var.private_inbound_acl_rules["rule_number"]
  rule_action     = var.private_inbound_acl_rules["rule_action"]
  from_port       = lookup(var.private_inbound_acl_rules, "from_port", null)
  to_port         = lookup(var.private_inbound_acl_rules, "to_port", null)
  protocol        = var.private_inbound_acl_rules["protocol"]
  cidr_block      = lookup(var.private_inbound_acl_rules, "cidr_block", null)
}

resource "aws_network_acl_rule" "private_outbound" {

  network_acl_id = aws_network_acl.private.id

  egress          = true
  rule_number     = var.private_outbound_acl_rules["rule_number"]
  rule_action     = var.private_outbound_acl_rules["rule_action"]
  from_port       = lookup(var.private_outbound_acl_rules, "from_port", null)
  to_port         = lookup(var.private_outbound_acl_rules, "to_port", null)
  protocol        = var.private_outbound_acl_rules["protocol"]
  cidr_block      = lookup(var.private_outbound_acl_rules, "cidr_block", null)
}

# Create database subnets
resource "aws_subnet" "db" {
  count             = length(var.db_subnet)
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.db_subnet[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(var.tags, {
    Name = "ffng-db-subnet0${count.index + 1}"
  })
}

# Create database route table
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(var.tags, {
    Name = "ffng-db-private-01"
  })
}

# Associate db subnets with the db subnet route table
resource "aws_route_table_association" "db" {
  count          = length(aws_subnet.db)
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db.id
}

# Create Database network acl for database subnet
resource "aws_network_acl" "database" {
    vpc_id     = aws_vpc.aws_vpc.id
    subnet_ids = aws_subnet.db[*].id
  

  tags = merge(var.tags, {
    Name = "ffng-database-nacl"
  })
}

# Create Database network acl rules for database subnet
resource "aws_network_acl_rule" "database_inbound" {

  network_acl_id = aws_network_acl.database.id

  egress          = false
  rule_number     = var.database_inbound_acl_rules["rule_number"]
  rule_action     = var.database_inbound_acl_rules["rule_action"]
  from_port       = lookup(var.database_inbound_acl_rules, "from_port", null)
  to_port         = lookup(var.database_inbound_acl_rules, "to_port", null)
  protocol        = var.database_inbound_acl_rules["protocol"]
  cidr_block      = lookup(var.database_inbound_acl_rules, "cidr_block", null)
}

resource "aws_network_acl_rule" "database_outbound" {

  network_acl_id = aws_network_acl.database.id

  egress          = true
  rule_number     = var.database_outbound_acl_rules["rule_number"]
  rule_action     = var.database_outbound_acl_rules["rule_action"]
  from_port       = lookup(var.database_outbound_acl_rules, "from_port", null)
  to_port         = lookup(var.database_outbound_acl_rules, "to_port", null)
  protocol        = var.database_outbound_acl_rules["protocol"]
  cidr_block      = lookup(var.database_outbound_acl_rules, "cidr_block", null)
}

# Create NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.aws_eip.id
  subnet_id     = aws_subnet.public[0].id
  depends_on = [
    aws_eip.aws_eip
  ]

  tags = merge(var.tags, {
    Name = "ffng-nat-01"
  })
}

# Create EIP for NAT gateway
resource "aws_eip" "aws_eip" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "ffng-eip-01"
  })
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc.id

  tags = merge(var.tags, {
    Name = "ffng-igw-01"
  })
}















