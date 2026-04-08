terraform {
  backend "s3" {
    bucket         = "atharva-devops-project"   
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"                
    dynamodb_table = "terraform-lock"           
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}