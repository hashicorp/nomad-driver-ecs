# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

log_level  = "DEBUG"
datacenter = "dc1"
data_dir   = "/tmp/nomad-server-1"
name       = "nomad-server-1"

server {
  enabled          = true
  bootstrap_expect = 1
  num_schedulers   = 1
}
