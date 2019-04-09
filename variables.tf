variable "scenario" {
  description = "Scenario name to be executed"
  default     = "tgw-mesh-scenario"
}

variable "public_key" {
  description = "Instance Public key to execute under"
  default     = "ssh-rsa AAAAB3NzaC1y...qd4hssndQ== rsa-key-20180518"
}
