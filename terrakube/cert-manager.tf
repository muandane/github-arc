
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  create_namespace = true
  atomic           = true

  # Add any additional configuration values
  set {
    name  = "installCRDs"
    value = "true"
  }

  # Wait for the resources to be ready
  wait = true

  # Configure dependencies
  depends_on = [helm_release.ingress_nginx]
}

resource "kubernetes_secret" "letsencrypt_private_key" {
  metadata {
    name      = "letsencrypt-private-key"
    namespace = "cert-manager"
  }

  data = {
    "tls.key" = "${file("tls.key")}"
    "tls.crt" = "${file("tls.crt")}"
  }

  type = "kubernetes.io/tls"
}

# Create a secret for OVH API credentials
resource "kubernetes_secret" "ovh_credentials" {
  metadata {
    name      = "ovh-credentials"
    namespace = "cert-manager"
  }

  data = {
    "application-secret" = var.ovh_application_secret
  }
}

# # Create the ClusterIssuer manifest
## Seperate this from this module
resource "kubernetes_manifest" "letsencrypt_cluster_issuer" {
  depends_on = [helm_release.cert_manager]
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt"
    }
    "spec" = {
      "acme" = {
        "email"  = var.acme_email
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "privateKeySecretRef" = {
          "name" = kubernetes_secret.letsencrypt_private_key.metadata.0.name
        }
        "solvers" = [
          {
            "dns01" = {
              "webhook" = {
                "groupName"  = "ovh"
                "solverName" = "ovh"
                "config" = {
                  "endpoint"       = "ovh-eu"
                  "applicationKey" = var.ovh_application_key
                  "applicationSecretRef" = {
                    "name" = kubernetes_secret.ovh_credentials.metadata.0.name
                    "key"  = "application-secret"
                  }
                  "consumerKey" = var.ovh_consumer_key
                }
              }
            }
          }
        ]
      }
    }
  }
}
