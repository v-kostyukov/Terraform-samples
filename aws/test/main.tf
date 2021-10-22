provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    bucket         = "terraform-up-state-2021"
    key            = "workspaces-example/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
