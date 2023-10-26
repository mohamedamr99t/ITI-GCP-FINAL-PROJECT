output "instance_id" {
  description = "The instance ID."
  value       = google_compute_instance.vmmanagement.id
}

output "instance_name" {
  description = "The instance name."
  value       = google_compute_instance.vmmanagement.name
}


