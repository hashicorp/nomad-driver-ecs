variable "vpc_cidr_block" {
  description = "The CIDR block range to use when creating the VPC."
  type        = string
  default     = "10.0.0.0/24"
}

variable "ecs_task_definition_file" {
  description = "The file that contains the ECS task definition, used as a deployment/update trick."
  type        = string
  default     = "./files/base-demo.json"
}

variable "region" {
  description = "AWS region for ECS cluster. Update Nomad config if not using the default."
  type        = string
  default     = "us-east-1"
}
