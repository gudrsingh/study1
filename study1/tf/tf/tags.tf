# Define the provider
provider "aws" {
  region = "us-east-1" # Specify the AWS region
}

# Input variable for VPC ID
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

# Input variable for tag key and value
variable "subnet_tag_key" {
  description = "The key of the tag used to identify the subnet"
  type        = string
  default     = "Name"
}

variable "subnet_tag_value" {
  description = "The value of the tag used to identify the subnet"
  type        = string
}

# Data source to fetch subnet ID dynamically based on tag
data "aws_subnet" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:${var.subnet_tag_key}"
    values = [var.subnet_tag_value]
  }
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
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.selected.id

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
