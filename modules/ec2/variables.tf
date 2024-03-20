variable "ec2_name" {}

variable "ami_id" {
    description = "AMI for EC2"
    default = "ami-04f9a173520f395dd"
}

variable "instance_type" {
    description = "Type of EC2"
    # default = "t2.micro"
}

variable "env_tag" {
    description = "Environment"
    default = "Dev"
}

variable "subnet_id" {}


variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs"
}
