terraform {
  # Version of Terraform to include in the bundle. An exact version number
  # is required.
  version = "0.13.0"
}

# Define which provider plugins are to be included
providers {
  # Include the newest "aws" provider version in the 1.0 series.
  aws = {
    version = "3.2.0"
  }

}