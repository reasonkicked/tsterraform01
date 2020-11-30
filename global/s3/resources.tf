/*resource "aws_s3_bucket" "terraform_state" {
  bucket = "tsterraform01-s3"

  lifecycle {
    prevent_destroy = false
  }

  versioning {
    enabled = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}*/
/*terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "tsterraform01-s3"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"

    # Replace this with your DynamoDB table name!
   // dynamodb_table = "terraform-up-and-running-locks"
   // encrypt        = true
  }
}*/