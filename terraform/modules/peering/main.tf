provider "aws" {
    alias  = "virginia"
    region = "us-east-1"
}

provider "aws" {
    alias  = "peer"
    region = "us-west-2"
}

resource "aws_vpc_peering_connection" "peering" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.vpc_accepter
  vpc_id        = var.vpc_requester
  peer_region   = "us-west-2"
  auto_accept   = false

  tags = {
    Name = "lks-vpc-peering"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  auto_accept               = true
}

resource "aws_route" "route_virginia" {
  provider = aws.virginia
  route_table_id            = var.rtb_virginia
  destination_cidr_block    = var.cidr_oregon
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

resource "aws_route" "route_oregon" {
  provider = aws.peer
  route_table_id            = var.rtb_oregon
  destination_cidr_block    = var.cidr_virginia
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}