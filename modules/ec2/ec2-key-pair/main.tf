terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "tsterraform01-s3"
    key            = "terraform_state/terraform.tfstate"
    region         = "us-west-2"

    # Replace this with your DynamoDB table name!
   // dynamodb_table = "terraform-up-and-running-locks"
   // encrypt        = true
  }
}

//temporary, key from PC
resource "aws_key_pair" "key_pair" {
  key_name = var.name_of_key
  public_key = file(var.public_key_path)
}
