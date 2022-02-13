provider "aws" {
  region = "eu-north-1"
}


resource "aws_instance" "my_ubuntu" {
  count         = 2
  ami           = "ami-092cce4a19b438926"
  instance_type = "t3.micro"

  tags = {
    Name    = "Linux"
    Owner   = "Ayub"
    Project = "Terraform"
  }
}
