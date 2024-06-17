job "stock-service" {
  datacenters = ["dc1"]

  group "postgres" {
    count = 1

    network {
      mode = "host"
      port "db" {
        to = 5432
      }
    }

    service {
      name = "postgres"
      port = "db"
      provider = "consul"
    }

    task "postgres" {
      driver = "docker"

      config {
        image = "postgres:15"
        ports = ["db"]
        network_mode = "host"
      }

      env {
        POSTGRES_DB = "stockdb"
        POSTGRES_USER = "stock-service"
        POSTGRES_PASSWORD = "stock-service"
      }

      resources {
        cores = 1
        memory = 512
      }
    }
  }

  group "stock-service" {
    count = 1

    network {
      mode = "host"
      port "app" {
        to = 8080
      }
    }

    service {
      name = "stock-service"
      port = "app"
      provider = "consul"
    }

    task "stock-service" {
      driver = "docker"

      config {
        image = "respawnables/stock-service:latest"
        ports = ["app"]
        network_mode = "host"
      }

      env {
        //SPRING_DATASOURCE_URL = "jdbc:postgresql://postgres.service.consul/stockdb"
        SPRING_DATASOURCE_USERNAME = "stock-service"
        SPRING_DATASOURCE_PASSWORD = "stock-service"
        SPRING_JPA_HIBERNATE_DDL_AUTO = "create-drop"
      }

      resources {
        cores = 1
        memory = 1024
      }
    }
  }
}
