resource "aws_ecr_repository" "predictor" {
  name = "predictor"
  image_scanning_configuration { scan_on_push = true }
}
