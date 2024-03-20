output "Jenkins_public_ip" {
  value = module.jenkins.ec2_public_ip
}

output "Kops_public_ip" {
  value = module.kops.ec2_public_ip
}

output "Monitor_public_ip" {
  value = module.monitor.ec2_public_ip
}

output "Sonar_public_ip" {
  value = module.sonar.ec2_public_ip
}