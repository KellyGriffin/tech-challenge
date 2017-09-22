job "terraform" {
  datacenters = ["dc1"]
  type = "service"
  update {
    max_parallel = 5
  }
  group "cache" {
    count = 1
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    ephemeral_disk {
      size = 300
    }
    task "website" {
      driver = "docker"
      config {
        image = "chrismatteson/terraform-website"
        port_map = {
          http = 4567
        }
        command = "/website2/scripts/build.sh"
        work_dir = "/website"
      }
      resources {
        cpu    = 1000
        memory = 512
        network {
          mbits = 10
          mbits = 10
          port "http" {}
        }
      }
      service {
        name = "global-website-check"
        tags = ["global", "cache"]
        port = "http"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
