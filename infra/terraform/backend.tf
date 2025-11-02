terraform {
  backend "local" {
    path = "terraform.tfstate"
    # bucket       = "terraform-state-bucket"
    # key          = "global/s3/terraform.tfstate"
    # region       = "us-east-1"
    # use_lockfile = true
  }
}
