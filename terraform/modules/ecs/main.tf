locals {
  container_name = "${var.project_name}-${var.env}-nextjs"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-${var.env}-ecs-cluster"
}

resource "aws_ecs_task_definition" "nextjs" {
  family                   = "${var.project_name}-${var.env}-nextjs"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      "name" : local.container_name,
      "image" : "${var.ecr_repo_url}",
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 3000,
          "hostPort" : 3000,
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-region" : "ap-northeast-1",
          "awslogs-stream-prefix" : "nextjs",
          "awslogs-group" : "${aws_cloudwatch_log_group.ecs_nextjs_log_group.name}"
        }
      },
      "secrets" : [
        {
          "name" : "HOGE",
          "valueFrom" : "${var.aws_ssm_parameter_env_hoge_arn}"
        },
        {
          "name" : "DATABASE_URL",
          "valueFrom" : "${var.aws_ssm_parameter_env_database_url_arn}"
        },
        {
          "name" : "FIREBASE_PRIVATE_KEY",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_private_key_arn}"
        },
        {
          "name" : "FIREBASE_CLIENT_EMAIL",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_client_email_arn}"
        },
        {
          "name" : "FIREBASE_PROJECT_ID",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_project_id_arn}"
        },
        {
          "name" : "FIREBASE_API_KEY",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_api_key_arn}"
        },
        {
          "name" : "FIREBASE_AUTH_DOMAIN",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_auth_domain_arn}"
        },
        {
          "name" : "FIREBASE_STORAGE_BUCKET",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_storage_bucket_arn}"
        },
        {
          "name" : "FIREBASE_MESSAGING_SENDER_ID",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_messaging_sender_id_arn}"
        },
        {
          "name" : "FIREBASE_APP_ID",
          "valueFrom" : "${var.aws_ssm_parameter_env_firebase_app_id_arn}"
        },
        {
          "name" : "API_BASE_URL",
          "valueFrom" : "${var.aws_ssm_parameter_env_api_base_url}"
        }
      ],
    }
  ])
}

resource "aws_ecs_service" "nextjs" {
  name            = "${var.project_name}-${var.env}-nextjs"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.nextjs.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = var.aws_lb_target_group_alb_arn
    container_name   = local.container_name
    container_port   = 3000
  }

  network_configuration {
    subnets          = [var.private_subnet_a_id, var.private_subnet_c_id]
    security_groups  = [aws_security_group.nextjs.id]
    assign_public_ip = false
  }
}

resource "aws_security_group" "nextjs" {
  vpc_id = var.vpc_id
  name   = "${var.project_name}-${var.env}-nextjs-sg"

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [var.aws_security_group_alb_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_appautoscaling_target" "ecs" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.nextjs.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_up" {
  name               = "scale-up"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = 1
      metric_interval_lower_bound = 0
    }
  }
}

resource "aws_appautoscaling_policy" "scale_down" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = -1
      metric_interval_upper_bound = 0
    }
  }
}
