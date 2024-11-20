terraform {
  required_providers {

    google = {
      source  = "hashicorp/google"
      version = ">= 4.72, < 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "./modules/vpc"

  project_id   = var.project_id
  network_name = var.network_name
  description  = var.description

  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  mtu                                    = var.mtu
}