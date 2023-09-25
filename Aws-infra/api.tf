
data "local_file" "api_json" {
  filename   = "Api_Config/Api_config.json"
}


locals {
  config_data   = jsondecode(data.local_file.api_json.content)
  function_names = local.config_data["function_names"]
  Api_names = local.config_data["Api_names"]
  stage_name = local.config_data["stage_name"]
  apikey_name = local.config_data["apikey_name"]
  api_key_required = local.config_data["api_key_required"]
}

module "api" {
  source = "./API/Modules"
  count         = length(local.function_names)
  name = local.Api_names[count.index]
  function_name = local.function_names[count.index]
  stage_name = local.stage_name
  apikey_name = local.apikey_name
  api_key_required = local.api_key_required[count.index]
  depends_on = [ module.lambda ]
}