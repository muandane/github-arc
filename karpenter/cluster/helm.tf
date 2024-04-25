resource "helm_release" "karpenter" {
  depends_on = [azurerm_role_assignment.karpenter_role_miop]
  name       = "karpenter"
  chart      = "oci://ksnap.azurecr.io/karpenter/snapshot/karpenter"
  version    = "0-f83fadf2c99ffc2b7429cb40a316fcefc0c4752a"
  namespace  = "kube-system"
  atomic     = true
  values     = ["${file("karpenter-values-template.yaml")}"]
  set {
    name  = "controller.resources.requests.cpu"
    value = "1"
  }
  set {
    name  = "controller.resources.requests.memory"
    value = "1Gi"
  }
  set {
    name  = "controller.resources.limits.cpu"
    value = "1"
  }
  set {
    name  = "controller.resources.limits.memory"
    value = "1Gi"
  }
}
