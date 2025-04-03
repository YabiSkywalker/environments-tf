resource "aws_iam_role" "this" {
  name = var.iam_role_name
  assume_role_policy = var.iam_role_policy
}

resource "aws_iam_policy" "this" {

  name        = var.iam_policy_name
  path        = "/"
  description = "Allow "
  policy      = var.iam_policy_document
}

resource "aws_iam_role_policy_attachment" "some_bucket_policy" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_instance_profile" "this" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.this.name
}

/*

jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })


  jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*\/*",
          "arn:aws:s3:::${var.iam_policy_resource}"
        ]
      }
    ]
  })

*/