provider "aws" {
  region = "eu-central-1"
}

### EC2
resource "aws_instance" "example" {
  ami           = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data     = <<-EOF
                  #!/bin/bash
                  echo "Hello world" > index.html
                  echo "${data.terraform_remote_state.db.outputs.address}" >> index.html
                  echo "${data.terraform_remote_state.db.outputs.port}" >> index.html
                  nohup busybox httpd -f -p ${var.server_port} &
                  EOF
  tags = {
    Name = "terraform-example"
  }
}

### SG
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-up-state-2021"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "terraform-up-state-2021"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "eu-central-1"
  }
}

