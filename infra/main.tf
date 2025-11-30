provider "aws" {
  region = "us-east-1"
}

# ------------------------------
# VPC and Subnets (you already have them)
# ------------------------------
data "aws_vpc" "selected" {
  id = "vpc-0d6207dd192fe6cf1" # your existing VPC
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_security_group" "ecs_sg" {
  id = "sg-01870628fbf1035d8" # your ECS app SG
}

# ------------------------------
# ECS Execution Role
# ------------------------------
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attach" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ------------------------------
# ECS Cluster
# ------------------------------
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"
}

# ------------------------------
# ECS Task Definition
# ------------------------------
resource "aws_ecs_task_definition" "myapp_task" {
  family                   = "myapp-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn

  container_definitions = jsonencode([
    {
      name      = "myapp"
      image     = "836347553182.dkr.ecr.us-east-1.amazonaws.com/myapp:latest"
      memory    = 512
      cpu       = 256
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])
}

# ------------------------------
# ECS Service
# ------------------------------
resource "aws_ecs_service" "myapp_service" {
  name            = "myapp-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.myapp_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.selected.ids
    security_groups  = [data.aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_policy_attach
  ]
}

