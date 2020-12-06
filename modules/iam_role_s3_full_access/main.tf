resource "aws_iam_role" "iam_role_s3_full_access" {
  name = "iam_role_s3_full_acces"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*", 
            "Resource": "s3-wp-media-ts"
        }
        
    ]
}
EOF

  tags = {
    Name = "iam_role_s3_full_access"
  }
}