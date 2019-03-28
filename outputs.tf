output "public_ip" {
  value = "${aws_instance.test-tgw-instance3-shared.public_ip}"
}
