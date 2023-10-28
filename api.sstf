resource "kubernetes_deployment" "api" {
  metadata {
    name      = "api"
    namespace = "tech-challenge"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "api"
      }
    }

    template {
      metadata {
        labels = {
          app = "api"
        }
      }

      spec {

        container {
          name  = "api"
          image = "httpd:latest"
          image_pull_policy = "Always"

          port {
            container_port = 80
          }

          env {
            name  = "DB_USERNAME"
            value = "user"
          }

          env {
            name  = "DB_PASSWORD"
            value = "password"
          }

          env {
            name  = "DB_DSN"
            value = "mysql:host=database-service;port=3306;dbname=FIAP_CHALLENGE;"
          }

          liveness_probe {
            http_get {
              path = "/healthcheck"
              port = "80"
            }

            initial_delay_seconds = 10
            timeout_seconds       = 10
            period_seconds        = 15
            success_threshold     = 1
            failure_threshold     = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api_service" {
  metadata {
    name      = "api-service"
    namespace = "tech-challenge"

    labels = {
      app = "api"
    }
  }

  spec {
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 80
      target_port = "80"
    }

    selector = {
      app = "api"
    }

    type = "LoadBalancer"
  }
}

