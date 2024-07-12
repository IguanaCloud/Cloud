resource "kubernetes_secret" "gitea" {
  metadata {
    name      = "regcred"
    namespace = kubernetes_namespace.gitea.metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = (jsonencode({
      "auths" = {
        "${var.registry_domain}" = {
          "username" = var.username,
          "password" = var.password,
          "email"    = var.mail,
          "auth"     = base64encode("${var.username}:${var.password}")
        }
      }
    }))
  }
}

data "google_secret_manager_secret_version" "tls_cert" {
  secret = "gogs-certs"  
  version = "latest"
  project = var.project
}

data "google_secret_manager_secret_version" "tls_key" {
  project = var.project
  secret = "gogs-key"  
  version = "latest"
}

resource "kubernetes_secret" "gogs_https_cert_key" {
  metadata {
    name = "gogs-tls"
    namespace = kubernetes_namespace.gitea.metadata[0].name
  }

  data = {
    "tls.crt" = data.google_secret_manager_secret_version.tls_cert.secret_data
    "tls.key" = data.google_secret_manager_secret_version.tls_key.secret_data
  }

  type = "kubernetes.io/tls"
}

