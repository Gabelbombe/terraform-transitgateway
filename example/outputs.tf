output "public_ip" {
  description = "The Public IP that is assigned to the instance"
  value       = "${module.gateway_mesh.public_ip}"
}
