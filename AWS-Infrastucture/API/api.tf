
module "api" {
  source = "./Modules"
  count         = length(local.api_configs)
  name = keys(local.api_configs[count.index].config)[0]
  function_name = values(local.api_configs[count.index].config)[0].function_names
  stage_name = values(local.api_configs[count.index].config)[0].stage_name
  apikey_name = values(local.api_configs[count.index].config)[0].apikey_name
  api_key_required = values(local.api_configs[count.index].config)[0].api_key_required
}
