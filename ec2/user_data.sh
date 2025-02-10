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
sudo docker run -d -p 80:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html:ro nginx
