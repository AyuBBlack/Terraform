#---------------------MY Terraform------------------------#
#--------------------Bild Server--------------------------#
#-------------------Made Ayub Block-----------------------#
#-------------------Made Ayub Block-----------------------#

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "Terra" {
  count                  = 2
  ami                    = "ami-013126576e995a769"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["aws_security_group.web_server.id"]
  user_data              = <<EOF
sudo yum update -y
yum install httpd
myip=`curl http://16.170.216.54/latest/meta-data/local-ipv4`
echo "<h2>Web Server with IP: $myip</h2><br> by Terraform" > /var/www/html.index
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name    = "Linux"
    Owner   = "Ayub"
    Project = "Terraform"
  }
}

resource "aws_security_group" "web_server" {
  name        = "Web Server Security Group"
  description = "MySecurityGroup"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "credentials"
  }
}
