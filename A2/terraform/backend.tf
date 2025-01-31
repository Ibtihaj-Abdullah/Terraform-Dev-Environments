terraform {
  backend "s3" {
    bucket         = "terraform-a2-bucket" 
    key            = "tfstates/terraform.tfstate"          
    region         = "us-west-2"                          
    encrypt        = true                                 
    dynamodb_table = "terraform-a2-state-lock"               
  }
}