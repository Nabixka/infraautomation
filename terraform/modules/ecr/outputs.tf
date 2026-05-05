output "fe_arn" {
    description = "ECR Virginia ARN"
    value = aws_ecr_repository.fe.arn
}

output "fe_url" {
    description = "ECR Oregon URL"
    value = aws_ecr_repository.fe.repository_url
}

output "api_arn" {
    description = "ECR Virginia ARN"
    value = aws_ecr_repository.api.arn
}

output "api_url" {
    description = "ECR Oregon URL"
    value = aws_ecr_repository.api.repository_url
}

output "analytics_arn" {
    description = "ECR Virginia ARN"
    value = aws_ecr_repository.analytics.arn
}

output "analytics_url" {
    description = "ECR Oregon URL"
    value = aws_ecr_repository.analytics.repository_url
}