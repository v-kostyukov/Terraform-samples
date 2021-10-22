provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-state-2021"

  # Предотвращаем случайное удаление бакета S3
  lifecycle {
    prevent_destroy = true
  }
  # Включаем управление версиями для просмотра всей истории файлов состояния
  versioning {
    enabled = true
  }
  # Включаем шифрование по умолчанию на стороне сервера
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    //bucket         = "terraform-up-state-2021"
    key            = "global/s3/terraform.tfstate"
    //region         = "eu-central-1"
    //dynamodb_table = "terraform-up-and-running-locks"
    //encrypt        = true
  }
}
