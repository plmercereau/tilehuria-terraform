output "vm_container_label" {
  description = "The instance label containing container configuration"
  value       = module.gce-rabbitmq-container.vm_container_label
}

output "container" {
  description = "The container metadata provided to the module"
  value       = module.gce-rabbitmq-container.container
}

output "volumes" {
  description = "The volume metadata provided to the module"
  value       = module.gce-rabbitmq-container.volumes
}

output "instance_name" {
  description = "The deployed instance name"
  value       = local.rabbitmq_instance_name
}

output "ipv4" {
  description = "The public IP address of the deployed instance"
  value       = google_compute_instance.rabbitmq.network_interface.0.access_config.0.nat_ip
}

# output "cos_image_name" {
#   description = "The cos image used"
#   value       = var.cos_image_name
# }
