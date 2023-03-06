

resource "aws_ecr_repository" "nomadphone_messagerouter" {
  name                 = "nomadphone/message-router"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
