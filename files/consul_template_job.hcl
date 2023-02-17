job "consul-template-job" {
  datacenters = ["home"]
  type        = "service"

  group "nomad-gossip-rotation-group" {
    count = 1

    task "nomad-gossip-rotation-task" {
      driver = "raw_exec"

      config {
        command = "/usr/bin/consul-template"
        args    = ["-config", "/opt/nomad/templates/nomad_gossip_rotation.hcl"]
      }

      service {
        name = "nomad-gossip-rotation"
      }

    }
  }

  group "consul-gossip-rotation-group" {
    count = 1

    task "consul-gossip-rotation-task" {
      driver = "raw_exec"

      config {
        command = "/usr/bin/consul-template"
        args    = ["-config", "/opt/consul/templates/consul_gossip_rotation.hcl"]
      }

      service {
        name = "nomad-gossip-rotation"
      }

    }
  }


}
