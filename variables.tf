variable "talos_version" {
description = "Version of Talos"
type = string
}

variable "talos_extensions" {
  description = "List of Talos system extensions"
  type = list(string)
}

variable "controlplanes" {
  description = "Map of controlplane nodes with their mac address"
}

variable "workers" {
  description = "Map of worker nodes with their mac address"
}

variable "vmworkers" {
  description = "Map of worker nodes (VM) with their mac address"
}
