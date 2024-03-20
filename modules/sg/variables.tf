variable "security_group_name" {
  description = "Name of the security group"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "ingress_rules" {
  description = "Ingress rules"
  type        = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    # security_groups = list(string)
    description     = string
  }))
}

variable "egress_rules" {
  description = "Egress rules"
  type        = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    # security_groups = list(string)
    #description     = string
  }))
}

# variable "tags" {
#   description = "Security group tag"
#   type        = map(string)
# }
