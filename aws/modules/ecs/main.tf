# ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "iovision-cluster"

  tags = {
    Name = "iovision-cluster"
  }
}

# IAM Role pour ECS Task Execution
resource "aws_iam_role" "task_exec_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "task_exec_policy" {
  role       = aws_iam_role.task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition
resource "aws_ecs_task_definition" "task_def" {
  family                   = "my-task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.task_exec_role.arn

  container_definitions = jsonencode([
    {
      name      = "container"
      image     = var.container_image
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "ecs_service" {
  name            = "iovision-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_def.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "container"
    container_port   = 80
  }

  network_configuration {
    assign_public_ip = true
    subnets          = var.subnets
    security_groups  = [var.security_group_id]
  }

  depends_on = [
    aws_iam_role.task_exec_role
  ]
}
