
locals {
  layer_configurations_dir = "${path.module}/configurations/layer*"
}

locals {
  layer_configs = flatten([
    for json_file in fileset(local.layer_configurations_dir, "*.json") :
    {
      product = dirname(json_file)
      config  = jsondecode(file(abspath("${local.layer_configurations_dir}/${json_file}")))
    }
  ])
}