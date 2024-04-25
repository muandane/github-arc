resource "helm_release" "arc_controller" {
  name             = "arc-controller"
  chart            = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller"
  namespace        = "arc-systems"
  create_namespace = true
  atomic           = true
  values           = ["${file("arc-controller.yaml")}"]
  depends_on       = [azurerm_kubernetes_cluster.arc_cluster]
}
resource "helm_release" "arc_scale_set" {
  name             = "arc-runner-scale-set"
  chart            = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set"
  namespace        = "arc-runners"
  create_namespace = true
  atomic           = true

  set {
    name  = "githubConfigUrl"
    value = var.github_url
  }

  set {
    name  = "githubConfigSecret.github_token"
    value = var.github_pat
  }
  set {
    name  = "template.spec.containers[0].image"
    value = "ghcr.io/simplifi-ed/internaldockerimage:v2.315.0"
  }
  set {
    name  = "template.spec.containers[0].imagePullPolicy"
    value = "Always"
  }

  depends_on = [azurerm_kubernetes_cluster.arc_cluster, helm_release.arc_controller]
}
