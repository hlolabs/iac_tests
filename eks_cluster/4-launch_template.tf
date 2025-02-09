resource "aws_launch_template" "eks_launch_template" {
  name_prefix   = "eks-launch-template-"
  image_id      = "ami-0abcdef1234567890"  # Substitua pelo ID da AMI desejada
  instance_type = "t3.medium"
  key_name      = "MyKeyPair"  # Substitua pelo nome do seu par de chaves

  user_data     = base64encode(data.template_file.user_data.rendered)

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks-node"
    }
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")
}
