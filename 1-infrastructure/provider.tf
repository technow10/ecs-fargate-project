provider "aws" {
    region = "${var.region}"
    profile = "cloud-admn-user"

}

 # store the terraform state file in s3
terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-fargate-project"
    key            = "terraform-module/ecs-fagate/terraform-tfstate"
    region         = "us-east-1"
    profile        = "cloud-admn-user"
  }
}
