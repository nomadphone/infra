resource "aws_iam_policy" "ecr_policy" {
  name        = "ECRPushPullAccess"
  path        = "/"
  description = "Gives access to push and pull images from ECR"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

module "iam_github_oidc_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  name   = "github-oidc-role"

  subjects = ["nomadphone/*"]

  provider_url = "https://token.actions.githubusercontent.com"

  policies = {
    S3ReadOnly  = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    ECRPushPull = aws_iam_policy.ecr_policy.arn
  }

  tags = {
    Environment = "test"
  }
}
