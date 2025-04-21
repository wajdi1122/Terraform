terraform {
  backend "s3" {
    bucket = "iovision-bucket"
    key    = "env/dev/terraform.tfstate"
    region = "us-east-1"
  }
}