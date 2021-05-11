# Nomad ECS Driver Plugin (Experimental)
The Nomad ECS driver plugin is an experimental type of remote driver plugin. Whereas traditional Nomad driver plugins rely on running processes locally to the client, this experiment allows for the control of tasks at a remote destination. The driver is responsible for the lifecycle management of the remote process, as well as performing health checks and health decisions.

**Warning: this is an experimental feature and is therefore supplied without guarantees and is subject to change without warning. Do not run this in production.**

Nomad v1.1.0-beta1 or later is required.

## Demo
A full demo can be found within the [demo directory](./demo) that will run through the full lifecycle of a task run under the ECS driver. It includes Terraform code to build the required AWS resources, as well as the Nomad configuration files and job specifications needed.

## Driver Configuration
In order to use the ECS driver, the binary needs to be executable and placed within the Nomad client's plugin directory. Please refer to the [Nomad plugin documentation](https://nomadproject.io/docs/configuration/plugin/) for more detail regarding the configuration.

The Nomad ECS driver plugin supports the following configuration parameters:
 * `enabled` - (bool: false) A boolean flag to control whether the plugin is enabled.
 * `cluster` - (string: """) The ECS cluster name where tasks will be run.
 * `region` - (string: "") The AWS region to send all requests to.

A example client plugin stanza looks like the following:

```hcl
plugin "nomad-driver-ecs" {
  config {
    enabled = true
    cluster = "nomad-remote-driver-cluster"
    region  = "us-east-1"
  }
}
```

## ECS Task Configuration
The Nomad ECS drivers includes the functionality to run [ECS tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html) via exposing configuration parameters within the Nomad jobspec. Please note, the ECS task definition is not created as part of the Nomad workflow and must be created prior to running a driver task. The below configuration summarises the current options, for further details about each parameter please refer to the [AWS sdk](https://github.com/aws/aws-sdk-go-v2/blob/9fc62ee75d1acca973ac777e51993fce74f6a27f/service/ecs/api_op_RunTask.go#L13).

In order to configure a ECS task within a Nomad task stanza, the config requires an initial `task` block as so:
```hcl
config {
    task {
      ...
    }
}
```

#### Top Level Task Config Options
 * `launch_type` - The launch type on which to run your task.
 * `task_definition` - The family and revision (family:revision) or full ARN of the task definition to run.
 * `network_configuration` - The network configuration for the task.

#### network_configuration Config Options
 * `aws_vpc_configuration` - The VPC subnets and security groups associated with a task.

#### aws_vpc_configuration Config Options
 * `assign_public_ip` - Whether the task's elastic network interface receives a public IP address.
 * `security_groups` - The security groups associated with the task or service.
 * `subnets` - The subnets associated with the task or service.

A full example of a Nomad task stanza which runs an ECS task:
```hcl
task "http-server" {
  driver = "ecs"

  config {
    task {
      launch_type     = "FARGATE"
      task_definition = "my-task-definition:1"
      network_configuration {
        aws_vpc_configuration {
          assign_public_ip = "ENABLED"
          security_groups  = ["sg-05f444f6c0dda876d"]
          subnets          = ["subnet-0cd4b2ec21331a144", "subnet-0da9019dcab8ae2f1"]
        }
      }
    }
  }
}
```
