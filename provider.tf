terraform {
  required_providers {
    matchbox = {
      source  = "poseidon/matchbox"
      version = "0.5.4"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.7.0-alpha.0"
    }
  }
}

provider "matchbox" {
  endpoint    = "matchbox.lan:8081"
  client_cert = file("certs/client.crt")
  client_key  = file("certs/client.key")
  ca          = file("certs/ca.crt")
}
