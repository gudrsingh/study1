# Define the provider
provider "aws" {
  region = "us-east-1" # Specify the AWS region
}

# Input variable for VPC ID
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

# Input variable for the subnet ID within the VPC
variable "subnet_id" {
  description = "The ID of the subnet within the VPC"
  type        = string
}

# Input variable for the instance type
variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Input variable for the AMI ID
variable "ami_id" {
  description = "The ID of the AMI"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI ID for us-east-1 region (Example)
}

# Resource to create an EC2 instance
resource "aws_instance" "example" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id

  # Tag for the instance
  tags = {
    Name = "example-instance"
  }
}

# Output the instance ID
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}
