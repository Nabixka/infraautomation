provider "aws" {
  region = "us-east-1"
  alias = "virginia"

  default_tags {
    tags = {
      Project     = "lks2026"
      Environment = "production"
      ManagedBy   = "Terraform"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  alias = "oregon"

  default_tags {
    tags = {
      Project     = "lks2026"
      Environment = "production"
      ManagedBy   = "Terraform"
    }
  }
}


# API
resource "aws_ecs_task_definition" "api-tf" {
  provider = aws.virginia
  family                = var.api_family
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu = "1024"
  execution_role_arn = var.iam
  task_role_arn = var.iam
  memory = "3072"
  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "lks-fe-container",
        "image": "339712797974.dkr.ecr.us-east-1.amazonaws.com/lks-api-app:2bf19b59530de3434d8bd93d9ec46540f42cc626",
            "cpu": 0,
            "portMappings": [
                {
                    "containerPort": 8080,
                    "hostPort": 8080,
                    "protocol": "tcp",
                    "name": "lks-api-container-8080-tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [],
            "environmentFiles": [],
            "mountPoints": [],
            "volumesFrom": [],
            "ulimits": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/lks-api-service",
                    "awslogs-create-group": "true",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
  }
]
TASK_DEFINITION
}

resource "aws_ecs_cluster" "api" {
  provider = aws.virginia
  name = "lks-api-cluster"
}


# Frontend
resource "aws_ecs_task_definition" "fe-tf" {
  provider = aws.virginia
  family                = var.fe_family
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu = "1024"
  memory = "3072"
  execution_role_arn = var.iam
  task_role_arn = var.iam
  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "lks-fe-container",
        "image": "339712797974.dkr.ecr.us-east-1.amazonaws.com/lks-api-app:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "containerPort": 3000,
                    "hostPort": 3000,
                    "protocol": "tcp",
                    "name": "lks-fe-container-3000-tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [],
            "environmentFiles": [],
            "mountPoints": [],
            "volumesFrom": [],
            "ulimits": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/lks-fe-service",
                    "awslogs-create-group": "true",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
  }
]
TASK_DEFINITION
}

resource "aws_ecs_cluster" "fe" {
  provider = aws.virginia
  name = "lks-fe-cluster"
}

# Analystic

resource "aws_ecs_task_definition" "analytics-tf" {
  provider = aws.virginia
  family                = var.analytics_family
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu = "1024"
  memory = "3072"
  execution_role_arn = var.iam
  task_role_arn = var.iam
  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "lks-analytics-container",
        "image": "339712797974.dkr.ecr.us-east-1.amazonaws.com/lks-analytics-app:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "containerPort": 5000,
                    "hostPort": 5000,
                    "protocol": "tcp",
                    "name": "lks-analytics-container-5000-tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [],
            "environmentFiles": [],
            "mountPoints": [],
            "volumesFrom": [],
            "ulimits": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/lks-analytics-service",
                    "awslogs-create-group": "true",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
  }
]
TASK_DEFINITION
}

resource "aws_ecs_cluster" "analytics" {
  provider = aws.virginia
  name = "lks-analytics-cluster"
}