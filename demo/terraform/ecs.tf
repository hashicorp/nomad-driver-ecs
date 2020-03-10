resource "aws_ecs_cluster" "nomad_remote_driver_demo" {
  name = "nomad-remote-driver-demo"
}

resource "aws_ecs_task_definition" "nomad_remote_driver_demo" {
  family                   = "nomad-remote-driver-demo"
  container_definitions    = file(var.ecs_task_definition_file)
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
}
