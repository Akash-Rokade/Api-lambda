
 resource "aws_lambda_function" "my_lambda"{
  function_name=  var.function_name
  handler      = var.handler
  runtime      = var.runtime 
  role         = aws_iam_role.lambda_role.arn 
  count         = length(var.layer_name)
  layers = [aws_lambda_layer_version.lambda_layer[count.index].arn] 
  filename     = var.filename   
  timeout = var.timeout
  memory_size = var.memory_size
 }


resource "aws_iam_role" "lambda_role" {
  name = var.role

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_layer_version" "lambda_layer" {
  count         = length(var.layer_name)
  filename     = var.layer_filename[count.index] 
  layer_name = var.layer_name[count.index]
  
  compatible_runtimes = var.compatible_runtimes
}