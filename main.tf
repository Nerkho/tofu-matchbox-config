locals {
  kernel = "https://pxe.factory.talos.dev/image/${talos_image_factory_schematic.image_factory.id}/${var.talos_version}/kernel-amd64"
  initrd = "https://pxe.factory.talos.dev/image/${talos_image_factory_schematic.image_factory.id}/${var.talos_version}/initramfs-amd64.xz"
}

resource "matchbox_profile" "controlplane" {
  name   = "controlplane"
  kernel = local.kernel
  initrd = [local.initrd]
  args = [
    "initrd=initramfs.xz",
    "init_on_alloc=1",
    "slab_nomerge",
    "pti=on",
    "console=tty0",
    "console=ttyS0",
    "printk.devkmsg=on",
    "talos.platform=metal",
    "net.ifnames=0",
    # "talos.experimental.wipe=system",
    "talos.config=http://matchbox.lan:8080/assets/talos/controlplane.yaml"
  ]
}

resource "matchbox_group" "controlplane" {
  for_each = var.controlplanes
  name     = each.key
  profile  = matchbox_profile.controlplane.name
  selector = {
    mac = each.value
  }
}

resource "matchbox_profile" "worker" {
  name   = "worker"
  kernel = local.kernel
  initrd = [local.initrd]
  args = [
    "initrd=initramfs.xz",
    "init_on_alloc=1",
    "slab_nomerge",
    "pti=on",
    "console=tty0",
    "console=ttyS0",
    "printk.devkmsg=on",
    "talos.platform=metal",
    "talos.config=http://matchbox.lan:8080/assets/talos/worker.yaml"
  ]
}

resource "matchbox_group" "worker" {
  for_each = var.workers
  name     = each.key
  profile  = matchbox_profile.worker.name
  selector = {
    mac = each.value
  }
}

resource "matchbox_profile" "vmworker" {
  name   = "vmworker"
  kernel = local.kernel
  initrd = [local.initrd]
  args = [
    "initrd=initramfs.xz",
    "init_on_alloc=1",
    "slab_nomerge",
    "pti=on",
    "console=tty0",
    "console=ttyS0",
    "printk.devkmsg=on",
    "talos.platform=metal",
    "talos.config=http://matchbox.lan:8080/assets/talos/vmworker.yaml"
  ]
}

resource "matchbox_group" "vmworker" {
  for_each = var.vmworkers
  name     = each.key
  profile  = matchbox_profile.vmworker.name
  selector = {
    mac = each.value
  }
}
