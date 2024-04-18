# resource "helm_release" "ingress_nginx" {
#   name             = "ingress-nginx"
#   repository       = "https://kubernetes.github.io/ingress-nginx"
#   chart            = "ingress-nginx"
#   namespace        = "ingress"
#   create_namespace = true
# }

resource "helm_release" "terrakube" {
  name             = "terrakube"
  chart            = "terrakube"
  repository       = "https://AzBuilder.github.io/terrakube-helm-chart"
  namespace        = "terrakube"
  create_namespace = true
  atomic           = true
  values = [
    "${file("values.yaml")}"
  ]
  depends_on = [azurerm_kubernetes_cluster.tk_cluster]
}

