module "vpc" {
  source   = "./modules/vpc"
  vpc_name = "gitlab"
}

# MODULES FOR JENKINS
module "jenkins" {
  source             = "./modules/ec2"
  ec2_name           = "jenkins"
  instance_type      = "t3.small"
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.jenkins_sg.security_group_id]
}

module "jenkins_sg" {
  source              = "./modules/sg"
  security_group_name = "Jenkins"
  vpc_id              = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP for Jenkins"
    },
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# MODULES FOR SONARQUBE
module "sonar" {
  source             = "./modules/ec2"
  ec2_name           = "sonar"
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.sonar_sg.security_group_id] 
}

module "sonar_sg" {
  source              = "./modules/sg"
  security_group_name = "sonar"
  vpc_id              = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    },
    {
      from_port   = 9000
      to_port     = 9000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "sonarqube"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# MODULES FOR GRAFANA AND PROMETHEUS
module "monitor" {
  source             = "./modules/ec2"
  ec2_name           = "monitor"
  instance_type      = "t3.small"
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.monitor_sg.security_group_id] 
}

module "monitor_sg" {
  source              = "./modules/sg"
  security_group_name = "monitor"
  vpc_id              = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    },
    {
      from_port   = 9090
      to_port     = 9090
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "prometheus"
    },
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "grafana"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# MODULES FOR KOPS
module "kops" {
  source             = "./modules/ec2"
  ec2_name           = "kops"
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.kops_sg.security_group_id] 
}

module "kops_sg" {
  source              = "./modules/sg"
  security_group_name = "kops"
  vpc_id              = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# KOPSE STATE BUCKET
resource "aws_s3_bucket" "s3-kops" {
  bucket  = "gitlab-kops-state-1503"
  tags = {
    Environment = "Dev"
  }
}

