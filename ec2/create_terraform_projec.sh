#!/bin/bash

# Nome do diretório do projeto
PROJECT_DIR="terraform-aws-ec2-docker-nginx"

# Criar a estrutura de diretórios
mkdir -p $PROJECT_DIR

# Criar e escrever conteúdo nos arquivos
cat <<EOL > $PROJECT_DIR/providers.tf
provider "aws" {
  region = var.region
}
EOL

cat <<EOL > $PROJECT_DIR/variables.tf
variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = ""
}

variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID for us-east-1
}
EOL

cat <<EOL > $PROJECT_DIR/main.tf
resource "aws_security_group" "allow_http" {
  name_prefix = "allow_http"

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  security_groups = [aws_security_group.allow_http.name]

  user_data = file("user_data.sh")

  tags = {
    Name = "nginx-docker-example"
  }
}
EOL

cat <<EOL > $PROJECT_DIR/outputs.tf
output "instance_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
EOL

cat <<EOL > $PROJECT_DIR/user_data.sh
#!/bin/bash

# Update the package repository
sudo yum update -y

# Install Docker
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# Create a simple web page
echo "<h1>Hello from Nginx!</h1>" > index.html

# Run Nginx container with the simple web page
sudo docker run -d -p 80:80 -v \$(pwd)/index.html:/usr/share/nginx/html/index.html:ro nginx
EOL

# Tornar o script user_data.sh executável
chmod +x $PROJECT_DIR/user_data.sh

echo "Estrutura de pastas e arquivos criados com sucesso em $PROJECT_DIR"
