provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-hello-cluster"
}

resource "kubernetes_namespace" "hello" {
  metadata {
    name = "hello"
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}
