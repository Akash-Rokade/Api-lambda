
data "local_file" "lambda_json" {
  filename   = "Lambda_Config/Lambda_config.json"
}


locals {
  lambda_config_data   = jsondecode(data.local_file.lambda_json.content)
  function_names_lambda = local.lambda_config_data["function_names"]
  file_paths     = local.lambda_config_data["filepath"]
  handler_name   = local.lambda_config_data["handler_name"]
  runtime        = local.lambda_config_data["runtime"]
  timeout        = local.lambda_config_data["timeout"]
  memory_size    = local.lambda_config_data["memory_size"]
  role_name      = local.lambda_config_data["role_name"] 
  layer_filename = local.lambda_config_data["layer_filename"]
  lambda_layer_name = local.lambda_config_data["layer_name"]
  compatible_runtimes = local.lambda_config_data["compatible_runtimes"]
}

module "lambda" {
  source = "./Lambda/Modules"
  count         = length(local.function_names_lambda)
  function_name=  local.function_names_lambda[count.index]
  handler      = local.handler_name[count.index]  
  runtime      = local.runtime[count.index]     
  role         = local.role_name[count.index]    
  filename     = local.file_paths[count.index]     
  timeout = local.timeout[count.index] 
  memory_size = local.memory_size[count.index]
  layer_filename     = local.layer_filename
  layer_name = local.lambda_layer_name 
  compatible_runtimes = local.compatible_runtimes
}