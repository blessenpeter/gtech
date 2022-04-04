
# VPC
resource "aws_vpc" "gtech-dev-vpc" {
  cidr_block = "10.0.0.0/16"
  #instance_tenancy = "default"

  tags = {
    name = "gtech-dev-vpc"
    created_by = "blessenpeter"
    created_via = "terraform"
    description = "vpc_for_gtech"

 
  }
}

# PUBLIC SUBNET 1
resource "aws_subnet" "gtech-dev-pub-sub-1" {
  vpc_id                  = aws_vpc.gtech-dev-vpc.id
  cidr_block              = "10.2.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true


  tags = {
    name = "gtech-dev-pub-sub-1"
    created_by = "blessenpeter"
    created_via = "terraform"
    description = "public_subnet1_for_gtech"
  }
}

# PUBLIC SUBNET 2
resource "aws_subnet" "gtech-prod-pub-sub-1" {
  vpc_id                  = aws_vpc.gtech-dev-vpc.id
  cidr_block              = "10.3.0.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    name = "gtech-prod-pub-sub-1"
    created_by = "blessenpeter"
    created_via = "terraform"
    description = "public_subnet2_for_gtech"
  }
}

# PRIVATE SUBNET 1
resource "aws_subnet" "gtech-dev-priv-sub-1" {
  vpc_id            = aws_vpc.gtech-dev-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    name = "PAP_E2E_PRV_SN1"
    created_by = "blessenpeter"
    created_via = "terraform"
    description = "private_subnet1_for_gtech"
  }
}

# PRIVATE SUBNET 2
resource "aws_subnet" "gtech-prod-priv-sub-1" {
  vpc_id            = aws_vpc.gtech-dev-vpc.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-east-1b"

  tags = {
    name = "gtech-prod-priv-sub-1"
    created_by = "blessenpeter"
    created_via = "terraform"
    description = "private_subnet2_for_gtech"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "gtech-dev-igw" {
  vpc_id = aws_vpc.gtech-dev-vpc.id

  tags = {
    name = "gtech-dev-igw"
    created_by = "blessenpeter"
    created_via = "terraform"
    description = "internet_gw_for_gtech"
  }
}

# # ELASTIC IP
# resource "aws_eip" "gtech-dev-eip" {
#   vpc = true
#   tags = {
#     name = "gtech-dev-eip"
#     created_by = "blessenpeter"
#     created_via = "terraform"
#     description = "elastic_ip_for_gtech"
#   }
# }

# # # NAT GATEWAY
# # resource "aws_nat_gateway" "gtech-dev-nat-gw" {
# #   allocation_id     = aws_eip.gtech-dev-eip.id
# #   connectivity_type = "public"
# #   subnet_id         = aws_subnet.gtech-dev-pub-sub-1.id
# #   tags = {
# #     name = "gtech-dev-nat-gw"
# #     created_by = "blessenpeter"
# #     reated_via = "terraform"
# #     description = "nat_gw_for_gtech"
# #   }
# # }

# PUBLIC ROUTE TABLE
resource "aws_route_table" "gtech-dev-pub-rt" {
  vpc_id = aws_vpc.gtech-dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtech-dev-igw.id
  }

  tags = {
    name = "gtech-dev-pub-rt"
    created_by = "blessenpeter"
    created_via = "terraform"
    description = "public_rt_for_gtech"
  }
}

# PUBLIC ROUTE TABLE & SUBNET ASSOCIATION PUBLIC SUBNET 1
resource "aws_route_table_association" "gtech-dev-pub-rt-association-1" {
  subnet_id      = aws_subnet.gtech-dev-pub-sub-1.id
  route_table_id = aws_route_table.gtech-dev-pub-rt.id
}

# PUBLIC ROUTE TABLE & SUBNET ASSOCIATION PUBLIC SUBNET 2
resource "aws_route_table_association" "gtech-dev-pub-rt-association-2" {
  subnet_id      = aws_subnet.gtech-prod-pub-sub-1.id
  route_table_id = aws_route_table.gtech-dev-pub-rt.id
}

# # # PRIVATE ROUTE TABLE
# # resource "aws_route_table" "gtech-dev-priv-rt" {
# #   vpc_id = aws_vpc.gtech-dev-vpc.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_nat_gateway.gtech-dev-nat-gw.id
# #   }

# #   tags = {
# #     name = "gtech-dev-priv-rt"
# #     created_by = "blessenpeter"
# #     reated_via = "terraform"
# #     description = "private_rt_for_gtech"
# #   }
# # }


# # # PRIVATE ROUTE TABLE & SUBNET ASSOCIATION PRIVATE SUBNET 1
# # resource "aws_route_table_association" "gtech-dev-priv-rt-association-1" {
# #   subnet_id      = aws_subnet.gtech-dev-priv-sub-1.id
# #   route_table_id = aws_route_table.gtech-dev-priv-rt.id
# # }

# # # PRIVATE ROUTE TABLE & SUBNET ASSOCIATION PRIVATE SUBNET 2
# # resource "aws_route_table_association" "gtech-dev-priv-rt-association-2" {
# #   subnet_id      = aws_subnet.gtech-prod-priv-sub-1.id
# #   route_table_id = aws_route_table.gtech-dev-priv-rt.id
# # }

