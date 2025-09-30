provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "vuln_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    exec > /home/ubuntu/deploy.log 2>&1
    
    echo "Starting deployment at $(date)"
    
    apt update -y
    apt install -y docker.io docker-compose git
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker ubuntu
    
    echo "Docker installation completed"
    
    # Clone and deploy application
    cd /home/ubuntu
    git clone https://github.com/bountyx1/assignment.git app
    echo "Repository cloned successfully"
    
    cd app/deploy
    docker-compose up -d
    echo "Docker compose deployment completed at $(date)"
    
    # Check if containers are running
    docker ps
    echo "Deployment script finished at $(date)"
  EOF

  tags = {
    Name = "devel"
  }
}

resource "aws_security_group" "web_sg" {
  name   = "web_sg"
  vpc_id = var.vpc_id
  
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
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}