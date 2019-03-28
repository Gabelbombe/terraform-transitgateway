/**
# Terraform Transit Gateway

* ```hcl
* module "security_monkey" {
*   source            = "git@github.com:ehime/terraform-transitgateway?ref=v1.0"
* }
* ```

See [example](example) for a complete example ....

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
