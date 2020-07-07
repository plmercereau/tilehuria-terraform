provider "google" {
  region      = var.region
  credentials = "${file("account.json")}"
}

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

resource "random_shuffle" "zone" {
  input        = data.google_compute_zones.available.names
  result_count = 1
}

