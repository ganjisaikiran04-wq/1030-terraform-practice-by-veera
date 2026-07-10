terraform {
  backend "s3" {
    bucket = "prashanth12332452"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
