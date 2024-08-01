remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "digger-demo-terragrunt-gcp-backend-floorball-fantasy"
    prefix = "${path_relative_to_include()}/terraform.tfstate"
    project = "floorball-fantasy"
    location  = "europe-west4"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.6.0"
    }
  }
}
provider "google" {
  project = "floorball-fantasy"
  region  = "europe-west4"
  zone    = "europe-west4-a"
}
EOF
}