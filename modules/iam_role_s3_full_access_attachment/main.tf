resource "aws_iam_role_policy_attachment" "ec2-read-only-policy-attachment" {
    role = var.role
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}