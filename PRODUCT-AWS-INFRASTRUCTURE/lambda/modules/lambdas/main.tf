
 resource "aws_lambda_function" "my_lambda"{
  function_name=  var.function_name
  handler      = var.handler
  runtime      = var.runtime 
  role         = aws_iam_role.lambda_role.arn 
  layers = [var.layer_arn] 
  filename     = var.filename   
  timeout = var.timeout
  memory_size = var.memory_size
 }

