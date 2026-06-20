provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "kind-hello-cluster"
  }
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = kubernetes_namespace.ingress_nginx.metadata[0].name
  create_namespace = false
  wait             = true
  timeout          = 300

  set {
    name  = "controller.hostPort.enabled"
    value = "true"
  }

  set {
    name  = "controller.hostPort.ports.http"
    value = "80"
  }

  set {
    name  = "controller.hostPort.ports.https"
    value = "443"
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }
}

resource "helm_release" "hello" {
  name              = "hello"
  namespace         = kubernetes_namespace.hello.metadata[0].name
  chart             = "../hello-chart"
  create_namespace  = false
  wait              = true
  timeout           = 300
  dependency_update = true

  depends_on = [helm_release.ingress_nginx]
}
