log_level  = "DEBUG"
datacenter = "dc1"

data_dir = "/tmp/nomad-client-2"
name     = "nomad-client-2"

client {
  enabled          = true
  servers          = ["localhost:4647"]
  max_kill_timeout = "3m" // increased from default to accomodate ECS.
}

ports {
  http = 6656
}

plugin "nomad-driver-ecs" {
  config {
    enabled = true
    cluster = "nomad-remote-driver-demo"
    region  = "us-east-1"
  }
}
