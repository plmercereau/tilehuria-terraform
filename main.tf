provider "google-beta" {
  credentials = "${file("account.json")}"
  project     = "tilehuria"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "rabbitmq"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config = {}
  }
}

# resource "random_pet" "table_name" {}


# resource "aws_dynamodb_table" "tfc_example_table" {
#   name = "${var.db_table_name}-${random_pet.table_name.id}"


#   read_capacity  = var.db_read_capacity
#   write_capacity = var.db_write_capacity
#   hash_key       = "UUID"


#   attribute {
#     name = "UUID"
#     type = "S"
#   }


#   tags = {
#     user_name = var.tag_user_name
#   }
# }

