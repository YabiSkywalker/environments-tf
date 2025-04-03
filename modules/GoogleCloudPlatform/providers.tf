provider "google" {
  project     = "umeet-platform"
  region      = "us-central1"
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.88.0"
    }
  }
}

