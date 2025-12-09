resource "aws_iam_role" "github" {
  name = "github-actions-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Federated = "arn:aws:iam::327263453975:oidc-provider/token.actions.githubusercontent.com" },
      Action = "sts:AssumeRoleWithWebIdentity"
    }]
  })
}

resource "aws_iam_role_policy" "gha_policy" {
  role = aws_iam_role.github.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      { Action = ["ecr:*"], Effect = "Allow", Resource = "*" },
      { Action = ["eks:*"], Effect = "Allow", Resource = "*" }
    ]
  })
}
