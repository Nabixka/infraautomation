output "vpc_oregon_id" {
  value = aws_vpc.this.id
}

output "vpc_oregon_subnet" {
  value = aws_subnet.isolated[*].id
}
output "vpc_oregon_rtb" {
  value = aws_route_table.isolated.id
}
