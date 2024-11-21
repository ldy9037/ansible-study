# Terraform Google Cloud NAT Module

This module handles opinionated Google Cloud Platform Cloud NAT creation and configuration.

**NOTE**: It is recommended to use the
[Cloud Router](https://github.com/terraform-google-modules/terraform-google-cloud-router/blob/master/examples/nat/main.tf)
module instead of this module. The Cloud Router module is more flexible and can be used to manage resources in addition
to NATs such as interconnects.

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.4.0](https://registry.terraform.io/modules/terraform-google-modules/-cloud-nat/google/v1.4.0).

## Usage

There are multiple examples included in the [examples](./examples/) folder but simple usage is as follows:

```hcl
module "cloud-nat" {
  source     = "../../../../modules/gcp/nat"
  
  project_id = var.project_id
  region     = var.region
  router     = google_compute_router.router.name
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2, < 1.6.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.72, < 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.73.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_router"></a> [create\_router](#input\_create\_router) | Create router instead of using an existing one, uses 'router' variable for new resource name. | `bool` | `false` | no |
| <a name="input_enable_dynamic_port_allocation"></a> [enable\_dynamic\_port\_allocation](#input\_enable\_dynamic\_port\_allocation) | Enable Dynamic Port Allocation. If minPorts is set, minPortsPerVm must be set to a power of two greater than or equal to 32. | `bool` | `false` | no |
| <a name="input_enable_endpoint_independent_mapping"></a> [enable\_endpoint\_independent\_mapping](#input\_enable\_endpoint\_independent\_mapping) | Specifies if endpoint independent mapping is enabled. | `bool` | `null` | no |
| <a name="input_icmp_idle_timeout_sec"></a> [icmp\_idle\_timeout\_sec](#input\_icmp\_idle\_timeout\_sec) | Timeout (in seconds) for ICMP connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |
| <a name="input_log_config_enable"></a> [log\_config\_enable](#input\_log\_config\_enable) | Indicates whether or not to export logs | `bool` | `false` | no |
| <a name="input_log_config_filter"></a> [log\_config\_filter](#input\_log\_config\_filter) | Specifies the desired filtering of logs on this NAT. Valid values are: "ERRORS\_ONLY", "TRANSLATIONS\_ONLY", "ALL" | `string` | `"ALL"` | no |
| <a name="input_max_ports_per_vm"></a> [max\_ports\_per\_vm](#input\_max\_ports\_per\_vm) | Maximum number of ports allocated to a VM from this NAT. This field can only be set when enableDynamicPortAllocation is enabled.This will be ignored if enable\_dynamic\_port\_allocation is set to false. | `string` | `null` | no |
| <a name="input_min_ports_per_vm"></a> [min\_ports\_per\_vm](#input\_min\_ports\_per\_vm) | Minimum number of ports allocated to a VM from this NAT config. Defaults to 64 if not set. Changing this forces a new NAT to be created. | `string` | `"64"` | no |
| <a name="input_name"></a> [name](#input\_name) | Defaults to 'cloud-nat-RANDOM\_SUFFIX'. Changing this forces a new NAT to be created. | `string` | `""` | no |
| <a name="input_nat_ips"></a> [nat\_ips](#input\_nat\_ips) | List of self\_links of external IPs. Changing this forces a new NAT to be created. Value of `nat_ip_allocate_option` is inferred based on nat\_ips. If present set to MANUAL\_ONLY, otherwise AUTO\_ONLY. | `list(string)` | `[]` | no |
| <a name="input_network"></a> [network](#input\_network) | VPN name, only if router is not passed in and is created by the module. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy to | `string` | n/a | yes |
| <a name="input_router"></a> [router](#input\_router) | The name of the router in which this NAT will be configured. Changing this forces a new NAT to be created. | `string` | n/a | yes |
| <a name="input_router_asn"></a> [router\_asn](#input\_router\_asn) | Router ASN, only if router is not passed in and is created by the module. | `string` | `"64514"` | no |
| <a name="input_router_keepalive_interval"></a> [router\_keepalive\_interval](#input\_router\_keepalive\_interval) | Router keepalive\_interval, only if router is not passed in and is created by the module. | `string` | `"20"` | no |
| <a name="input_source_subnetwork_ip_ranges_to_nat"></a> [source\_subnetwork\_ip\_ranges\_to\_nat](#input\_source\_subnetwork\_ip\_ranges\_to\_nat) | Defaults to ALL\_SUBNETWORKS\_ALL\_IP\_RANGES. How NAT should be configured per Subnetwork. Valid values include: ALL\_SUBNETWORKS\_ALL\_IP\_RANGES, ALL\_SUBNETWORKS\_ALL\_PRIMARY\_IP\_RANGES, LIST\_OF\_SUBNETWORKS. Changing this forces a new NAT to be created. | `string` | `"ALL_SUBNETWORKS_ALL_IP_RANGES"` | no |
| <a name="input_subnetworks"></a> [subnetworks](#input\_subnetworks) | Specifies one or more subnetwork NAT configurations | <pre>list(object({<br>    name                     = string,<br>    source_ip_ranges_to_nat  = list(string)<br>    secondary_ip_range_names = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tcp_established_idle_timeout_sec"></a> [tcp\_established\_idle\_timeout\_sec](#input\_tcp\_established\_idle\_timeout\_sec) | Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set. Changing this forces a new NAT to be created. | `string` | `"1200"` | no |
| <a name="input_tcp_time_wait_timeout_sec"></a> [tcp\_time\_wait\_timeout\_sec](#input\_tcp\_time\_wait\_timeout\_sec) | Timeout (in seconds) for TCP connections that are in TIME\_WAIT state. Defaults to 120s if not set. | `string` | `"120"` | no |
| <a name="input_tcp_transitory_idle_timeout_sec"></a> [tcp\_transitory\_idle\_timeout\_sec](#input\_tcp\_transitory\_idle\_timeout\_sec) | Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |
| <a name="input_udp_idle_timeout_sec"></a> [udp\_idle\_timeout\_sec](#input\_udp\_idle\_timeout\_sec) | Timeout (in seconds) for UDP connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Name of the Cloud NAT |
| <a name="output_nat_ip_allocate_option"></a> [nat\_ip\_allocate\_option](#output\_nat\_ip\_allocate\_option) | NAT IP allocation mode |
| <a name="output_region"></a> [region](#output\_region) | Cloud NAT region |
| <a name="output_router_name"></a> [router\_name](#output\_router\_name) | Cloud NAT router name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform and kubectl are [installed](#software-dependencies) on the machine where Terraform is executed.
2. The Service Account you execute the module with has the right [permissions](#iam-roles).
3. The APIs are [active](#enable-apis) on the project you will launch the cluster in.
4. If you are using a Shared VPC, the APIs must also be activated on the Shared VPC host project and your service account needs the proper permissions there.

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v4.27.0

### Configure a Service Account

In order to execute this module you must have a Service Account with the
following project roles:

- [roles/compute.networkAdmin](https://cloud.google.com/nat/docs/using-nat#iam_permissions)

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for information on contributing to this module.
