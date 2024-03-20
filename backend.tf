terraform {
  backend "s3" {
    bucket  = "gitlab-terraform-state-1503"
    key     = "terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}