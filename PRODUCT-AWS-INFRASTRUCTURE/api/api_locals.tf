
locals {
  api_configurations_dir = "${path.module}/configurations/api*"
}

locals {
  api_configs = flatten([
    for json_file in fileset(local.api_configurations_dir, "*.json") :
    {
      product = dirname(json_file)
      config  = jsondecode(file(abspath("${local.api_configurations_dir}/${json_file}")))
    }
  ])
}