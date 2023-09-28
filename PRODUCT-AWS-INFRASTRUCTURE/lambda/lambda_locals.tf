
locals {
  configurations_dir = "${path.module}/configurations/sub_product*"
}

locals {
  lambda_configs = flatten([
    for json_file in fileset(local.configurations_dir, "*.json") :
    {
      product = dirname(json_file)
      config  = jsondecode(file(abspath("${local.configurations_dir}/${json_file}")))
    }
  ])
}
