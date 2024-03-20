resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    security_groups = var.security_group_ids

    key_name = "gitlab"
    
    
    tags = {
        Name = var.ec2_name
        Environment = var.env_tag
    }
}