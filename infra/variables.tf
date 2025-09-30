variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
  default     = "vpc-0e15042d16bb092f9"
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
  default     = "subnet-0254fd1412457e471"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = "bounty-prod-key"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04"
  type        = string
  default     = "ami-0e35ddab05955cf57"
}