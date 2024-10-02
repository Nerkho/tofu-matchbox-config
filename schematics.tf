data "talos_image_factory_extensions_versions" "image_factory" {
  # get the latest talos version
  talos_version = var.talos_version
  filters = {
    names = var.talos_extensions
  }
}

resource "talos_image_factory_schematic" "image_factory" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.image_factory.extensions_info.*.name
        }
      }
    }
  )
}
