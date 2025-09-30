provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "vuln_app" {
  # Hardcoded AMI ID for Ubuntu 22.04 & Public Subnet ID of my account
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
  subnet_id = "subnet-0254fd1412457e471"
  key_name = "bounty-prod-key"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y docker.io docker-compose git
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker ubuntu
    
    # Clone and deploy application
    cd /home/ubuntu
    git clone https://github.com/bountyx1/assignment.git app
    cd app
    docker-compose up -d
  EOF

  tags = {
    Name = "devel"
  }
}



resource "aws_security_group" "web_sg" {
  name = "web_sg"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
