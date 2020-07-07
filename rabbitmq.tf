locals {
  rabbitmq_instance_name = format("%s-%s", var.rabbitmq_instance_name, substr(md5(module.gce-rabbitmq-container.container.image), 0, 8))
}

module "gce-rabbitmq-container" {
  source  = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"

  container = {
    image = "rabbitmq:3-alpine"

    env = [
      {
        RABBITMQ_ERLANG_COOKIE = var.rabbitmq_erlang_cookie
        RABBITMQ_DEFAULT_USER  = var.rabbitmq_default_user
        RABBITMQ_DEFAULT_PASS  = var.rabbitmq_default_password
      },
    ]

    # volumeMounts = [
    #   {
    #     mountPath = "/cache"
    #     name      = "tempfs-0"
    #     readOnly  = "false"
    #   },
    # ]
  }

  # volumes = [
  #   {
  #     name = "tempfs-0"

  #     emptyDir = {
  #       medium = "Memory"
  #     }
  #   },
  # ]

  restart_policy = "Always"
}

resource "google_compute_instance" "rabbitmq" {
  project      = var.project_id
  name         = var.rabbitmq_instance_name
  machine_type = "f1-micro"
  zone         = random_shuffle.zone.result[0]

  boot_disk {
    initialize_params {
      image = module.gce-rabbitmq-container.source_image
    }
  }

  network_interface {
    subnetwork_project = var.project_id
    subnetwork         = var.subnetwork
    access_config {}
  }

  # tags = ["container-vm-example"]

  metadata = {
    gce-container-declaration = module.gce-rabbitmq-container.metadata_value
  }

  labels = {
    container-vm = module.gce-rabbitmq-container.vm_container_label
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
