job "terraformweb" {
  datacenters = ["dc1"]
  type = "service"
  update {
    max_parallel = 2
    stagger = "30s"
  }
  group "cache" {
    count = 5
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
        name = "terraform-website-check"
        tags = ["terraform", "middleman"]
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
