output "public_ip" {
  description = "Public IP of your EC2 Instance"
  value       = "${aws_instance.test-tgw-instance3-shared.public_ip}"
}
