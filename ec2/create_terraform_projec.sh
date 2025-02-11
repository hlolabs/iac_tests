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
  default     = "my-key-pair"
}

variable "public_key_path" {
  description = "Path to the public key to be used for SSH access"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID for us-east-1
}
EOL

cat <<EOL > $PROJECT_DIR/main.tf
# Create a new VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_gw"
  }
}

# Create a route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create a security group
resource "aws_security_group" "allow_http" {
  vpc_id = aws_vpc.main.id
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

# Create an SSH key pair
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Create an EC2 instance
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = aws_subnet.public.id

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
