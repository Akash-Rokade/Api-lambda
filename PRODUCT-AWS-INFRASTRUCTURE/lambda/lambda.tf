
module "lambda" {
  source = "./modules/lambdas"
  count         = length(local.lambda_configs)
  function_name = keys(local.lambda_configs[count.index].config)[0]
  handler       = values(local.lambda_configs[count.index].config)[0].handler_name
 runtime       = values(local.lambda_configs[count.index].config)[0].runtime
  memory_size   = values(local.lambda_configs[count.index].config)[0].memory_size
  timeout       = values(local.lambda_configs[count.index].config)[0].timeout
  filename      = values(local.lambda_configs[count.index].config)[0].filepath
  role          = values(local.lambda_configs[count.index].config)[0].role_name
  layer_arn = module.layer[0].arn
  depends_on = [ module.layer]
}
