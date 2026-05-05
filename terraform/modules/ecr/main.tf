provider "aws" {
    alias  = "virginia"
    region = "us-east-1"
}

provider "aws" {
    alias  = "oregon"
    region = "us-west-2"
}

resource "aws_ecr_repository" "virginia" {
  provider = aws.virginia
  name                 = var.ecr_name_virginia
  image_tag_mutability = "MUTABLE"

}

resource "aws_ecr_repository" "oregon" {
  provider = aws.oregon
  name                 = var.ecr_name_oregon
  image_tag_mutability = "MUTABLE"
}