locals {
  subnet_keys = keys(module.subnets.subnets)
}

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

module "subnets" {
  source = "./modules/subnets"

  project_id   = var.project_id
  network_name = module.vpc.network_name

  subnets = var.subnets
}

resource "google_compute_instance" "vm" {
  count = length(var.vms)
  name         = var.vms[count.index].name
  machine_type = var.vms[count.index].type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.vms[count.index].os
      size  = var.vms[count.index].disk
    }

    auto_delete = true
  }

  network_interface {
    subnetwork = module.subnets.subnets[local.subnet_keys[0]].self_link
    network_ip = var.vms[count.index].ip
  }
}

resource "google_compute_firewall" "iap_all_ssh" {
  name    = var.firewall.iap_all_ssh.name
  network = module.vpc.network_name

  allow {
    protocol = var.firewall.iap_all_ssh.protocol
    ports    = var.firewall.iap_all_ssh.ports
  }

  source_ranges = var.firewall.iap_all_ssh.source_ranges
}
