output "vpc_id" {
    value = aws_vpc.gitlab.id
}

output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}

output "jenkins_sg_id" {
    value = ["${aws_security_group.jenkins_sg.id}"]
}