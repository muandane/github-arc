
## installing NGINX and Cert-Manager on an AKS Cluster

This document outlines the steps for installing NGINX Ingress Controller and Cert-Manager for automatic certificate management on an Azure Kubernetes Service (AKS) cluster.

### Prerequisites:

- Existing AKS cluster
- DNS provider such as Azure DNS or OVH (optional)

### Installation:

. *NGINX Ingress Controller Deployment:*

Use Helm to deploy the NGINX Ingress Controller. You can find the appropriate chart information from the official NGINX Ingress Controller project on [Nginx docs](https://docs.nginx.com/nginx-ingress-controller/installation/installing-nic/installation-with-helm/).

```hcl
resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  atomic           = true
  values           = ["${file("ingress.yaml")}"]
}
```

and the chart config:

```yaml
controller:
  allowSnippetAnnotations: true
  service:
    annotations:
      service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: /healthz
```

. *Cert-Manager Deployment:*

Deploy Cert-Manager using Helm:

```hcl
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
```

adding required resources to create a cluster issuer:

a private key and certificate, the base files can be created with openssl:

```sh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=domain.com"
```

then we add them with terraform to the cluster:

```hcl
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
```

in the case of using ovh:

```sh
git clone https://github.com/baarde/cert-manager-webhook-ovh.git
cd cert-manager-webhook-ovh
helm install cert-manager-webhook-ovh ./deploy/cert-manager-webhook-ovh --set groupName='<GROUP_NAME>'
```

```hcl
resource "kubernetes_secret" "ovh_credentials" {
  metadata {
    name      = "ovh-credentials"
    namespace = "cert-manager"
  }

  data = {
    "application-secret" = var.ovh_application_secret
  }
}

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
                "groupName"  = '<GROUP_NAME>'
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
```

## Installing Terrakube

To install terrakube you can use one of the examples provided by in the docs:

```hcl
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
}
```

The Auth examples can be found [here](https://github.com/AzBuilder/terrakube-helm-chart/tree/main/examples).
