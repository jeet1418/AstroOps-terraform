terraform {
  backend "s3" {
    bucket = "astro-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "astro-state-lock"
  }
}