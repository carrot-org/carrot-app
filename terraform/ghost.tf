# Review: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html

locals {
  host_port = "${var.app_index + var.host_port}"
}

resource "random_id" "ghost_fs_id" {
  keepers {
    name      = "${var.alb_arn}"
    app_index = "${var.app_index}"
  }

  prefix      = "ghost-"
  byte_length = 4
}

resource "random_id" "ghost_tg_id" {
  keepers {
    name          = "${var.alb_arn}"
    app_index     = "${var.app_index}"
    port          = "${local.host_port}"
    target_type   = "${var.target_type}"
    vpc_id        = "${var.vpc_id}"
    protocol_http = "${join(",", var.alb_protocols)}"

    # protocol_https = "${aws_lb_target_group.ghost_https.protocol}"
  }

  prefix      = "ghost-"
  byte_length = 4
}

data "template_file" "ghost-task-definition-json" {
  template = "${file("ghost.json")}"

  vars {
    hostname = "${random_id.ghost_tg_id.hex}.${var.tld}"
  }
}

resource "aws_ecs_task_definition" "ghost-task" {
  family = "${var.cluster_name}-${random_id.ghost_tg_id.hex}"

  container_definitions = "${data.template_file.ghost-task-definition-json.rendered}"

}

resource "aws_ecs_service" "ghost" {
  name            = "${var.environment}-${random_id.ghost_tg_id.hex}"
  cluster         = "${var.cluster_name}"
  task_definition = "${aws_ecs_task_definition.ghost-task.arn}"
  desired_count   = 1

  health_check_grace_period_seconds = 60
  deployment_minimum_healthy_percent = 0
  load_balancer {
    target_group_arn = "${aws_lb_target_group.ghost_http.arn}"
    container_name   = "ghost"
    container_port   = 2368
  }
}

resource "aws_lb_listener_rule" "host_based_routing" {
  listener_arn = "${var.alb_listener_arn}"
  priority     = "${var.app_index}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ghost_http.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${random_id.ghost_tg_id.hex}.${var.tld}"]
  }
}

resource "aws_lb_target_group" "ghost_http" {
  lifecycle {
    create_before_destroy = true
  }

  name     = "${random_id.ghost_tg_id.hex}"
  port     = "80"
  protocol = "${var.alb_protocols[0]}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval = 30
    path     = "/"

    # port = "${local.host_port}"
    matcher = "200"
  }
}
