resource "aws_lambda_layer_version" "lambda_layer" {
  filename     = var.layer_filename
  layer_name = var.layer_name
  
  compatible_runtimes = var.compatible_runtimes
}