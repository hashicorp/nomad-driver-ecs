# ECS Remote Driver Demo
The ECS remote driver demo shows how Nomad can be used to run, monitor and maintain tasks running on an AWS ECS cluster.

## ECS Driver Main Responsibilities
The remote driver is built in the same way, using the same interfaces as another other Nomad task driver. Its behaviour can differ slightly, depending on the remote endpoint. Therefore below is a short overview on the main task which the ECS driver must perform:
 * Driver Health: driver health is performed by performing a describe call on the ECS cluster
 * Driver Run: the main run function of the driver is responsible polling the ECS task, describing its health. If the task is in a terminal state, the driver exist its current loop and passes this information back to Nomad.

## Requirements
In order to run this demo, you will need the following items available.

 * An AWS account and API access credentials (specific policy requirements TBC)
 * Terraform > 0.12.0 - https://www.terraform.io/downloads.html
 * [Nomad v1.1.0-beta1 or later](https://releases.hashicorp.com/nomad/)

## Assumptions / Rough Edges
The demo makes some assumptions because of the quick, and local nature of it.
 * AWS access credentials will be available via environment variables or default profile. This is needed by Terraform and Nomad. Please see the [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html) for more details on setting this up.
 * The ECS cluster is running within `us-east-1`. If you need to change the AWS region please update `./nomad/{client-1,client-2,server}.hcl` files.

## Build Out
When running this demo, a small number of AWS resources will be created. The majority of these do not incur direct costs, however, the ECS task does. For mre information regarding this, please visit the [Fargate pricing document](https://aws.amazon.com/fargate/pricing/). Also beware AWS data transfer costs.

1. Change directory into the Terraform directory:
    ```
    $ cd ./terraform
    ```
1. Modify the Terraform variables file with any custom configuration. The file is located at `./terraform/variables.tf`.
1. Perform the Terraform initialisation:
    ```
    $ terraform init
    ```
1. Inspect the Terraform plan output and verify it is as expected:
    ```
    $ terraform plan -out=nomad-task-driver-demo
    ```
1. Apply the Terraform plan to build out the AWS resources:
    ```
    $ terraform apply -auto-approve nomad-task-driver-demo
    ```
1. The Terraform output will contain `demo_subnet_id` and `demo_security_group_id` values, these should be noted for later use.
1. Start the Nomad server and clients. Ideally each command is run in a separate terminal allowing for easy following of logs:
    ```
    $ cd ../nomad
    $ nomad agent -config=server.hcl
    $ nomad agent -config=client-1.hcl -plugin-dir=$(pwd)/plugins
    $ nomad agent -config=client-2.hcl -plugin-dir=$(pwd)/plugins
    ```
1. Check the ECS driver status on a client node:
    ```
    $ nomad node status # To see Node IDs
    $ nomad node status <node-id> |grep "Driver Status"
    ```

## Demo
The following steps will demonstrate how Nomad, and the remote driver handle multiple situations that operators will likely come across during day-to-day cluster management. Notably, how Nomad attempts to minimise the impact of task availability even when its availability is degraded.

1. Using the Terraform output from before, update the `nomad/demo-ecs.nomad` file to reflect these details. In particular these two parameters need updating:
    ```
    security_groups  = ["sg-0d647d4c7ce15034f"]
    subnets          = ["subnet-010b03f1a021887ff"]
    ```
1. Submit the remote task driver job to the cluster:
    ```
    $ nomad run demo-ecs.nomad
    ```
1. Check the allocation status, and the logs to show the client is remotely monitoring the task:
    ```
    $ nomad status nomad-ecs-demo
    $ nomad logs -f <alloc-id>
    ```
1. Navigate to the AWS ECS console and check the running tasks on the cluster. The URL will look like `https://console.aws.amazon.com/ecs/home?region=us-east-1#/clusters/nomad-remote-driver-demo/tasks`, but be sure to change the region if needed.
1. Drain the node on which the remote task is currently being monitored from. This will cause Nomad to create a new allocation, but will not impact the remote task:
    ```
    $ nomad node drain -enable <node-id> 
    ```
1. Here you can again check the logs of the new allocation and the AWS console to check the status of the ECS task. You should notice the remote task remains running, and the new allocation logs attach and monitor the same task as the previous allocation.
1. Remove the drain status from the previously drained node so that it is available for scheduling again:
    ```
    $ nomad node drain -disable <node-id>
    ``` 
1. Kill the Nomad client which is currently running to simulate a lost node situation. This can be done either by control-c of the process, or using kill -9.
1. Check the logs of the new allocation and the AWS console to check the status of the ECS task. You should notice the remote task remains running, and the new allocation logs attach, and monitor the same task as the previous allocation.
1. Now updated the ECS task definition. This process has been wrapped via Terraform using variables:
    ```
    $ cd ../terraform
    $ terraform apply -var 'ecs_task_definition_file=./files/updated-demo.json' -auto-approve
    ``` 
1. Update the job specification in order to deploy to new, updated task definition:
    ```
    $ cd ../nomad
    $ sed -ie "s/nomad-remote-driver-demo:1/nomad-remote-driver-demo:2/g" demo-ecs.nomad
    ```
1. Register the updated job on the Nomad cluster:
    ```
    $ nomad run demo-ecs.nomad
    ```
1. Observing the AWS console, there will be a new task provisioning. Filtering by status `stopped` shows the previous task in `stopping` status. Nomad has successfully deployed the new version of the task.
1. Stop the Nomad job and observe the task stopping within AWS:
    ```
    $ nomad stop nomad-ecs-demo
    ```

## Tear Down
1. Stop the Nomad clients and server processes, either by control-c or killing the process IDs.
1. Destroy the created AWS resources, performing a plan and checking the destroy is targeting the expected resources:
    ```
    $ cd ../terraform
    $ terraform plan -destroy
    $ terraform destroy -auto-approve
    ```
