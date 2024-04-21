
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
  depends_on = [helm_release.cert_manager]
}
