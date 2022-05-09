listener "tcp" {
  address = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable = "true"
}

storage "file" {
  path = "/home/vault/data"
}
ui = true