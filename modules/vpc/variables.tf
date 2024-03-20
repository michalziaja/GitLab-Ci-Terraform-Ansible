variable "vpc_name" {}

variable "cidr_block" {
    description = "Cidr for VPC"
    default = "10.0.0.0/16"
}

variable "cidr_subnet" {
    description = "Cidr for subnet"
    default = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "AZ"
  default = "eu-central-1a"
}

variable "env_tag" {
    description = "Tag"
    default = "Dev"
}