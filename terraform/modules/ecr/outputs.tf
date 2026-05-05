output "ecr_oregon_arn" {
    description = "ECR Oregon ARN"
    value = aws_ecr_repository.oregon.arn
}

output "ecr_virginia_arn" {
    description = "ECR Virginia ARN"
    value = aws_ecr_repository.virginia.arn
}

output "ecr_oregon_repo_url" {
    description = "ECR Oregon URL"
    value = aws_ecr_repository.oregon.repository_url
}

output "ecr_virginia_repo_url" {
    description = "ECR Virginia URL"
    value = aws_ecr_repository.virginia.repository_url
}