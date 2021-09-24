provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
  tags = {
    Name = "EC2-t2-micro-terraform"
  }
}
