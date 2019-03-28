/**
# Terraform Transit Gateway

This project gives an example of the usage [AWS Transit Gateway](https://aws.amazon.com/transit-gateway/) product. That component provides a way to interconnect multiple VPCs in a hub-spoke topology.

The Transit Gateway is meant to superseed the more complex and expensive Transit VPC technology. This is a didactic example to showcase how a Transit VPC should be configured to achieve a non-trivial (full mesh) scenario. I hope it helps someone!

* ```hcl
* module "gateway_mesh" {
*   source      = "git@github.com:ehime/terraform-transitgateway?ref=v1.0.2"
*   public_key  = "ssh-rsa AAAAB3NzaC1y...qd4hssndQ== rsa-key-20180518"
*   scenario    = "tgw-mesh-scenario"
* }
* ```

See [example](example) for a complete example ....


## Architecture
A Transit Gateway relies on Route Tables. By default, a new Route Table is created in the Transit Gateway, which populates with the routing info toward every VPC attached to the gateway (the full mesh scenario)
The Terraform code in this project demonstrates a more complex scenario in which traffic is isolated based on the environment. Four VPCs are created, with two subnets each (in separate AZs):
  - VPC-1: in the 'dev' environment
  - VPC-2: in the 'dev' environment
  - VPC-3: in the 'shared' environment
  - VPC-4: in the 'prod' environment

Let's assume the 'shared' environment will host shared components, such as proxy services, tools, ... Here are the rules we want our Transit Gateway to implement:
  - The shared VPC can access dev and prod VPCs.
  - The dev VPCs can access each other, and the shared VPC
  - The prod VPCs can only access the shared VPC

To enable such a scenario, three Route Tables are created in the Transit Gateway, one per environment. Which means both dev VPCs attach to the same Route Table, whereas the shared and prod VPCs each attach to their respective Route Table. Each VPC gets a t2.micro Ubuntu instance to validate the network connectivity over ssh and ICMP (ping). The instance in the 'shared' is assigned a public IP so a VPN connection isn't needed. Adding the necessary Terraform resources to establish a VPN connection could be an extension of this project.

![transit-gateway-architecture](assets/transit-gateway.png "Transit Gateway Architecture")

The thick green links on the diagram represents the authorized traffic through the gateway.


## Prerequisites
  - An AWS account
  - AWS Vault configured
  - Terraform


## Documentation generation
Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ |sed '$d' >| README.md
```

## License
GPL 3.0 Licensed. See [LICENSE](https://github.com/ehime/terraform-transitgateway/tree/master/LICENSE) for full details.
*/

provider "null" {}
provider "template" {}
