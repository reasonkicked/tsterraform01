resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = var.bucket
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity EDU6S5KRM2MS5"
            },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::s3-wp-media-ts/*"
         } 
  ]
}
POLICY
}