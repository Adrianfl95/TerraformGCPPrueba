terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("/home/adrian/Downloads/keys/serviceaccgcp-spring-petclinic-angular-key.json")

  project = "398065119144"
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

