terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.72, < 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
