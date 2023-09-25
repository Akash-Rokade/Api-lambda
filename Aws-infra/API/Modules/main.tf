
#######################################################


resource "aws_api_gateway_rest_api" "my_api" {
  name        = var.name
}

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "resource"
}

resource "aws_api_gateway_method" "my_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = var.api_key_required
}
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
}
resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.my_resource.id
  http_method             = aws_api_gateway_method.my_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.aws_lambda_function.lambda.invoke_arn 
}

data "aws_lambda_function" "lambda" {
  function_name = var.function_name
}

resource "aws_api_gateway_integration_response" "my_integration_response" {
  rest_api_id     = aws_api_gateway_rest_api.my_api.id
  resource_id     = aws_api_gateway_resource.my_resource.id
  http_method     = aws_api_gateway_method.my_method.http_method
  status_code     = "200"
  response_templates = {
    # "application/json" = ""
  }
    depends_on = [
    aws_api_gateway_integration.my_integration
  ]
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "my_method_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.my_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_deployment" "my_deployment" {
    
  depends_on  = [
    aws_api_gateway_integration.my_integration,
    aws_api_gateway_method_response.my_method_response,
    aws_api_gateway_integration_response.my_integration_response,
    aws_api_gateway_method.my_method
  ]
  rest_api_id = aws_api_gateway_rest_api.my_api.id
}

resource "aws_api_gateway_stage" "examplesbx" {
  count         = length(var.stage_name)
  deployment_id = aws_api_gateway_deployment.my_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  stage_name    = var.stage_name[count.index]
}


# Create an API key
resource "aws_api_gateway_api_key" "my_api_key" {
  count         = length(var.apikey_name)    
  name        = var.apikey_name[count.index]
  description = "My API Key"
}
