log_level  = "DEBUG"
datacenter = "dc1"

data_dir = "/tmp/nomad-client-1"
name     = "nomad-client-1"

client {
  enabled          = true
  servers          = ["127.0.0.1:4647"]
  max_kill_timeout = "3m" // increased from default to accomodate ECS.
}

ports {
  http = 5656
  rpc  = 5657
  serf = 5658
}

plugin "nomad-driver-ecs" {
  config {
    enabled = true
    cluster = "nomad-remote-driver-demo"
    region  = "us-east-1"
  }
}
