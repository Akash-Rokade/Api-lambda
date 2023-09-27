module "layer" {
  source = "./Modules/Lambda_layer"
  count         = length(local.layer_configs)
  layer_filename     = values(local.layer_configs[count.index].config)[0].layer_filename
  layer_name = keys(local.layer_configs[count.index].config)[0] 
  compatible_runtimes = values(local.layer_configs[count.index].config)[0].compatible_runtimes
}