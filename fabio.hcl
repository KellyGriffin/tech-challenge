job "fabio" {
  datacenters = ["dc1"]
  type = "service"
  update {
    max_parallel = 1
    stagger = "30s"
  }
  group "cache" {
    count = 2
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    ephemeral_disk {
      size = 300
    }
    task "loadbalancer" {
      driver = "docker"
      env {
        CONSUL_HTTP_ADDR = "${module.hashistack.primary_server_private_ips}"
      }
      config {
        image = "magiconair/fabio"
        port_map = {
          http = 80
        }
      }
      resources {
        cpu    = 500
        memory = 256
        network {
          mbits = 10
          mbits = 10
          port "http" {}
        }
      }
      service {
        name = "fabio-loadbalancer"
        tags = ["fabio", "loadbalancer"]
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
