## I'm pretty sure this is the equivalent of a Kubernetes config YAML file
provider "kubernetes" {}


resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-example"
    labels = {
      App = "ScalableNginxExample"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "example"

          port {
            container_port = 80
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

# A kubernetes service object acting as a load balancer
resource "kubernetes_service" "nginx" {
    metadata {
        name = "nginx-example"
    }
    spec {
        selector = {
            App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
        }
        port {
            port        = 443
            target_port = 443
        }

        type = "LoadBalancer"
    }
}

