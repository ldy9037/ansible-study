# Terraform Subnets Module

This submodule is part of the the `terraform-google-network` module. It creates the individual vpc subnets.

It supports creating:

- Subnets within vpc network.

## Usage

Basic usage of this submodule is as follows:

```hcl
module "subnets" {
    source  = "../../../../modules/gcp/subnets"

    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-west1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-west1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
            purpose               = "INTERNAL_HTTPS_LOAD_BALANCER"
            role                  = "ACTIVE"
        },
        {
            subnet_name                  = "subnet-03"
            subnet_ip                    = "10.10.30.0/24"
            subnet_region                = "us-west1"
            subnet_flow_logs             = "true"
            subnet_flow_logs_interval    = "INTERVAL_10_MIN"
            subnet_flow_logs_sampling    = 0.7
            subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_filter_expr = "true"
        }
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]

        subnet-02 = []
    }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2, < 1.6.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.72, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.73.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_subnetwork.subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network where subnets will be created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where subnets will be created | `string` | n/a | yes |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The list of subnets being created | `list(map(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The created subnet resources |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Subnet Inputs

The subnets list contains maps, where each object represents a subnet. Each map has the following inputs (please see examples folder for additional references):

| Name                         | Description                                                                                                     |  Type  |         Default          | Required |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------- | :----: | :----------------------: | :------: |
| subnet\_name                 | The name of the subnet being created                                                                            | string |            -             |   yes    |
| subnet\_ip                   | The IP and CIDR range of the subnet being created                                                               | string |            -             |   yes    |
| subnet\_region               | The region where the subnet will be created                                                                     | string |            -             |   yes    |
| subnet\_private\_access      | Whether this subnet will have private Google access enabled                                                     | string |        `"false"`         |    no    |
| subnet\_flow\_logs           | Whether the subnet will record and send flow log data to logging                                                | string |        `"false"`         |    no    |
| subnet\_flow\_logs\_interval | If subnet\_flow\_logs is true, sets the aggregation interval for collecting flow logs                           | string |    `"INTERVAL_5_SEC"`    |    no    |
| subnet\_flow\_logs\_sampling | If subnet\_flow\_logs is true, set the sampling rate of VPC flow logs within the subnetwork                     | string |         `"0.5"`          |    no    |
| subnet\_flow\_logs\_metadata | If subnet\_flow\_logs is true, configures whether metadata fields should be added to the reported VPC flow logs | string | `"INCLUDE_ALL_METADATA"` |    no    |
| subnet\_flow\_logs\_filter_expr | Export filter defining which VPC flow logs should be logged, see https://cloud.google.com/vpc/docs/flow-logs#filtering for formatting details  | string | `"true"` |    no    |
| purpose | The purpose of the subnet usage. Whether it is to be used as a regular subnet or for proxy or loadbalacing purposes, see https://cloud.google.com/vpc/docs/subnets#purpose for more details  | string | `"PRIVATE"` |    no    |
| role | The role of the subnet when using it as a proxy or loadbalancer network. Whether it is to be used as the active or as a backup subnet, see https://cloud.google.com/load-balancing/docs/proxy-only-subnets#proxy_only_subnet_create for more details  | string |            -             |    no    |
